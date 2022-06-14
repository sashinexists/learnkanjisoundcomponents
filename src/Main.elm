module Main exposing (..)

import Browser
import Browser.Dom as Dom exposing (Viewport)
import Browser.Events exposing (onKeyDown, onResize)
import Browser.Navigation as Nav
import Desktop
import Element exposing (..)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Font as Font
import Element.Input exposing (button)
import Html.Attributes
import Json.Decode as D
import Markdown
import Pages exposing (..)
import Phone
import Random exposing (..)
import Random.List exposing (..)
import Routes exposing (Route(..))
import Shared exposing (..)
import SoundComponent exposing (SoundComponent)
import SoundComponents exposing (soundComponents)
import Task exposing (Task)
import Theme exposing (..)
import Url exposing (..)


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


getRouteFromPath : String -> Route
getRouteFromPath path =
    case path of
        "/about" ->
            About

        "/ついて" ->
            About

        "/support" ->
            Support

        "/ありがとう" ->
            Support

        _ ->
            Home


type alias Flags =
    { x : Int
    , y : Int
    }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        model =
            { key = key
            , url = url
            , soundComponents = soundComponents
            , selected = []
            , display = ListByKanaRow
            , route = getRouteFromPath url.path
            , device = classifyDevice { height = flags.y, width = flags.x }
            }
    in
    ( model
    , Cmd.batch [ Task.perform GotViewport Dom.getViewport ]
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onKeyDown keyDownListener
        , onResize WindowResized
        ]


decodeKey : D.Decoder String
decodeKey =
    D.field "key" D.string


keyDownListener : D.Decoder Msg
keyDownListener =
    D.map KeyDown decodeKey


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.load (Url.toString url)
                    )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model
                | url = url
                , route = getRouteFromPath url.path
              }
            , Cmd.none
            )

        SelectSoundComponent soundComponent ->
            ( { model | selected = model.selected ++ [ soundComponent ] }
            , Cmd.none
            )

        DeselectSoundComponent soundComponent ->
            deselectSoundComponent model soundComponent

        KeyDown key ->
            handleKeyDown key model

        DisplayBy option ->
            ( { model | display = option, route = Home }, Cmd.none )

        Randomise ->
            ( model, Random.generate NewSoundComponentsList (Random.List.shuffle model.soundComponents) )

        NewSoundComponentsList soundComponents ->
            ( { model | soundComponents = soundComponents }, Cmd.none )

        WindowResized width height ->
            ( { model | device = classifyDevice { height = height, width = width } }, Cmd.none )

        GotViewport data ->
            ( { model | device = classifyDevice { height = round data.viewport.height, width = round data.viewport.width } }, Cmd.none )


handleKeyDown : String -> Model -> ( Model, Cmd Msg )
handleKeyDown key model =
    case key of
        "Escape" ->
            ( { model | selected = [] }, Cmd.none )

        _ ->
            ( model, Cmd.none )


deselectSoundComponent : Model -> SoundComponent -> ( Model, Cmd Msg )
deselectSoundComponent model soundComponent =
    let
        selection =
            List.filter (\s -> soundComponent /= s) model.selected
    in
    ( { model | selected = selection }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    case model.device.class of
        Desktop ->
            Desktop.view model

        Phone ->
            Phone.view model

        Tablet ->
            Desktop.view model

        -- later you might want to make a view for tablets
        _ ->
            Desktop.view model
