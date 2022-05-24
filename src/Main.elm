module Main exposing (..)

import Browser
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Border exposing (roundEach, rounded)
import Element.Font as Font
import Element.Input exposing (button)
import Html exposing (col)
import Json.Decode as D
import Meaning exposing (displayMeaning)
import Part exposing (getJapanesePartName)
import Radical exposing (Radical)
import Radicals exposing (radicals)
import Url exposing (..)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


type alias Model =
    { key : Nav.Key
    , url : Url
    , radicals : List Radical
    , selected : Maybe Radical
    , display : Display
    }


type Display
    = ListBySubject
    | ListByPart
    | NoCategories


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        model =
            { key = key
            , url = url
            , radicals = radicals
            , selected = Nothing
            , display = ListBySubject
            }
    in
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onKeyDown keyDownListener
        ]


decodeKey : D.Decoder String
decodeKey =
    D.field "key" D.string


keyDownListener : D.Decoder Msg
keyDownListener =
    D.map KeyDown decodeKey


type Msg
    = SelectRadical Radical
    | DeselectRadical
    | UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | KeyDown String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectRadical radical ->
            ( { model | selected = Just radical }, Cmd.none )

        DeselectRadical ->
            deselectRadical model

        KeyDown key ->
            handleKeyDown key model

        _ ->
            ( { model | selected = Nothing }, Cmd.none )


handleKeyDown : String -> Model -> ( Model, Cmd Msg )
handleKeyDown key model =
    case key of
        "Escape" ->
            deselectRadical model

        _ ->
            ( model, Cmd.none )


deselectRadical : Model -> ( Model, Cmd Msg )
deselectRadical model =
    ( { model | selected = Nothing }, Cmd.none )


colorPalette =
    { richBlack = rgb255 12 9 11
    , smokeyBlack = rgb255 23 18 21
    , raisinBlack = rgb255 31 27 31
    , raisinBlackLight = rgb255 35 46 41
    , blackCoffee = rgb255 57 45 52
    , culturedWhite = rgb255 245 244 245
    , gainsboro = rgb255 227 221 224
    }


theme =
    { fontColor = colorPalette.gainsboro
    , fontColorLighter = colorPalette.culturedWhite
    , bgColor = colorPalette.richBlack
    , contentBgColor = colorPalette.raisinBlack
    , contentBgColorDarker = colorPalette.smokeyBlack
    , contentBgColorLighter = colorPalette.blackCoffee
    , textSize = 16
    }


focusBoxShadow : { color : Color, offset : ( number, number ), blur : number, size : Int }
focusBoxShadow =
    { color = theme.contentBgColorDarker, offset = ( 1, 5 ), blur = 8, size = 1 }


titleBarButtonStyles : List (Attr () msg)
titleBarButtonStyles =
    [ padding 25
    , alignRight
    , height fill
    , Background.color theme.contentBgColor
    , mouseOver [ Background.color theme.contentBgColorLighter, Font.color theme.fontColorLighter ]
    ]


view : Model -> Browser.Document Msg
view model =
    { title = "Learn the Japanese Kanji Radicals"
    , body =
        [ layoutWith
            { options =
                [ focusStyle
                    (FocusStyle
                        (Just theme.contentBgColorLighter)
                        (Just theme.contentBgColorLighter)
                        (Just focusBoxShadow)
                    )
                ]
            }
            [ Font.family [ Font.typeface "Ubuntu" ]
            , Font.color theme.fontColor
            , Font.size theme.textSize
            , Font.regular
            , Font.justify
            , Background.color theme.bgColor
            , Element.inFront (displaySelectedRadical model.selected)
            ]
            (Element.column [ paddingEach { top = 10, bottom = 10, left = 60, right = 50 } ]
                [ viewHeader
                , Element.column
                    [ centerX
                    , centerY
                    , Font.center
                    , width fill
                    , paddingEach { top = 10, bottom = 20, left = 0, right = 0 }
                    ]
                    [ viewRadicals model.radicals
                    ]
                ]
            )
        ]
    }


viewHeader : Element Msg
viewHeader =
    Element.row [ centerY, Font.size 25, spaceEvenly, Font.alignRight, width fill, alignRight, height <| px <| 70 ]
        [ viewHeaderButtons
        , viewTitle
        ]


viewHeaderButtons : Element Msg
viewHeaderButtons =
    Element.row [ spacing 20, alpha 0 ]
        [ viewHeaderButton "主題" DeselectRadical
        , viewHeaderButton "部分" DeselectRadical
        ]


viewHeaderButton : String -> Msg -> Element Msg
viewHeaderButton label action =
    button
        [ Background.color colorPalette.raisinBlackLight
        , rounded 10
        , padding 15
        , Font.size 18
        , Font.center
        , mouseOver [ Background.color theme.contentBgColorLighter, Font.color theme.fontColorLighter ]
        ]
        { label = Element.text label
        , onPress = Just action
        }


viewTitle : Element Msg
viewTitle =
    Element.text "漢字の部首学ぶ教室へようこそ！！"


viewRadicals : List Radical -> Element Msg
viewRadicals radicals =
    Element.wrappedRow
        [ spacing 20
        , width fill
        ]
        (List.map viewRadical radicals)


viewRadical : Radical -> Element Msg
viewRadical radical =
    button
        [ Background.color theme.contentBgColor
        , rounded 10
        , width <| px <| 320
        , height <| px <| 200
        , Font.size 50
        , Font.center
        , mouseOver [ Background.color theme.contentBgColorLighter, Font.color theme.fontColorLighter ]
        ]
        { label =
            Element.column [ Font.center, centerX, centerY, spacing 20 ]
                [ Element.el [ Font.center, centerX, centerY ] (text (String.fromChar radical.radical))
                , Element.el [ Font.center, centerX, centerY, Font.size 20, alpha 0.3 ] (text radical.name)
                ]
        , onPress = Just (SelectRadical radical)
        }


displaySelectedRadical : Maybe Radical -> Element Msg
displaySelectedRadical selected =
    case selected of
        Just radical ->
            viewPopup radical

        Nothing ->
            text ""


viewPopup : Radical -> Element Msg
viewPopup radical =
    Element.column
        [ width fill
        , height fill
        , alpha 0.95
        , Background.color theme.bgColor
        , Element.inFront (viewSelectedRadical radical)
        ]
        []


viewSelectedRadical : Radical -> Element Msg
viewSelectedRadical radical =
    Element.column
        [ centerX
        , centerY
        , width fill
        , height fill
        , padding 60
        , alpha 1
        ]
        [ Element.row
            [ width fill
            , paddingEach { left = 20, top = 0, right = 0, bottom = 0 }
            , Background.color theme.contentBgColorDarker
            , alpha 1
            , roundEach { topLeft = 10, topRight = 10, bottomLeft = 0, bottomRight = 0 }
            ]
            [ button
                (titleBarButtonStyles ++ [ roundEach { topRight = 10, topLeft = 0, bottomLeft = 0, bottomRight = 0 } ])
                { label = text "⨉"
                , onPress = Just DeselectRadical
                }
            ]
        , Element.row
            [ centerX
            , centerY
            , height fill
            , width fill
            , spacing 50
            , roundEach { topLeft = 0, topRight = 0, bottomLeft = 10, bottomRight = 10 }
            , Background.color theme.contentBgColorDarker
            ]
            [ Element.el
                [ Font.size 200, Font.extraLight, width (fillPortion 1), Font.alignRight ]
                (text (String.fromChar radical.radical))
            , Element.column [ width (fillPortion 1), spacing 30, Font.alignLeft ]
                [ viewRadicalAttribute "名前" radical.name
                , viewRadicalAttribute "意味" (displayMeaning radical.meaning)
                , viewRadicalAttribute "部分" (getJapanesePartName radical.part)
                ]
            ]
        ]


viewRadicalAttribute : String -> String -> Element Msg
viewRadicalAttribute attribute value =
    Element.row
        [ centerX
        , centerY
        , height (fillPortion 1)
        , width fill
        , Font.alignLeft
        , Font.size 20
        ]
        [ Element.el
            [ centerY
            , Font.bold
            ]
            (text (attribute ++ ": "))
        , Element.el
            [ centerY
            ]
            (text value)
        ]
