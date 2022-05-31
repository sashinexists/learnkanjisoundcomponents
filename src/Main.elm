module Main exposing (..)

import Browser
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Font as Font
import Element.Input exposing (button)
import Html.Attributes
import Json.Decode as D
import Markdown
import Pages exposing (..)
import Random exposing (..)
import Random.List exposing (..)
import Routes exposing (Route(..))
import SoundComponent exposing (SoundComponent)
import SoundComponents exposing (soundComponents)
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
    , soundComponents : List SoundComponent
    , selected : List SoundComponent
    , display : Display
    , route : Route
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


type Display
    = ListByKanaRow
    | NoCategories


type KanaRow
    = AIUEO
    | KAKIKUKEKO
    | SASHISUSESO
    | TACHITSUTETO
    | NANINUNENO
    | HAHIFUHEHO
    | MAMIMUMEMO
    | YAYUYO
    | RARIRURERO
    | WAWO
    | N


printKanaRowInKana : KanaRow -> String
printKanaRowInKana kanaRow =
    case kanaRow of
        AIUEO ->
            "アイウエオ"

        KAKIKUKEKO ->
            "カキクケコ"

        SASHISUSESO ->
            "サシスセソ"

        TACHITSUTETO ->
            "タチツテト"

        NANINUNENO ->
            "ナニヌネノ"

        HAHIFUHEHO ->
            "ハヒフヘホ"

        MAMIMUMEMO ->
            "マミムメモ"

        YAYUYO ->
            "ヤユヨ"

        RARIRURERO ->
            "ラリルレロ"

        WAWO ->
            "ワヲ"

        N ->
            "ン"


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        model =
            { key = key
            , url = url
            , soundComponents = soundComponents
            , selected = []
            , display = NoCategories
            , route = getRouteFromPath url.path
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
    = SelectSoundComponent SoundComponent
    | DeselectSoundComponent SoundComponent
    | UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | DisplayBy Display
    | Randomise
    | KeyDown String


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
            ( { model | soundComponents = Random.List.shuffle model.soundComponents }, Cmd.none )


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


colorPalette =
    { richBlack = rgb255 12 9 11
    , smokeyBlack = rgb255 23 18 21
    , raisinBlack = rgb255 31 27 31
    , raisinBlackLight = rgb255 35 46 41
    , combuGreen = rgb255 53 70 62
    , blackCoffee = rgb255 57 45 52
    , culturedWhite = rgb255 245 244 245
    , gainsboro = rgb255 227 221 224
    , darkSienna = rgb255 61 20 37
    , darkerSienner = rgb255 39 1 16
    , oldMauve = rgb255 92 30 56
    , spaceCadet = rgb255 44 40 62
    , englishViolet = rgb255 61 56 87
    }


theme =
    { fontColor = colorPalette.gainsboro
    , fontColorLighter = colorPalette.culturedWhite
    , bgColor = colorPalette.richBlack
    , contentBgColor = colorPalette.raisinBlack
    , contentBgColorDarker = colorPalette.smokeyBlack
    , contentBgColorLighter = colorPalette.blackCoffee
    , buttonBgColor = colorPalette.raisinBlackLight
    , buttonBgHover = colorPalette.combuGreen
    , buttonBgColorAlt = colorPalette.spaceCadet
    , buttonBgHoverAlt = colorPalette.englishViolet
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


markdownOptions : Markdown.Options
markdownOptions =
    { githubFlavored = Just { tables = True, breaks = True }
    , defaultHighlighting = Nothing
    , sanitize = False
    , smartypants = True
    }


view : Model -> Browser.Document Msg
view model =
    { title = "Learn the Japanese Kanji SoundComponents"
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
            ]
            (Element.column [ paddingEach { top = 10, bottom = 10, left = 60, right = 50 }, width fill ]
                [ viewHeader model.display
                , case model.display of
                    NoCategories ->
                        viewSoundComponents model.selected model.soundComponents

                    ListByKanaRow ->
                        viewSoundComponentsByKana model.selected model.soundComponents
                ]
            )
        ]
    }


viewHomeRoute : Model -> Element Msg
viewHomeRoute model =
    Element.column
        [ centerX
        , centerY
        , Font.center
        , width fill
        , paddingEach { top = 10, bottom = 20, left = 0, right = 0 }
        ]
        [ case model.display of
            NoCategories ->
                viewSoundComponents model.selected model.soundComponents

            _ ->
                --you need to come back to this
                viewSoundComponents model.selected model.soundComponents
        ]


viewPage : Page -> Element Msg
viewPage page =
    Element.column
        [ paddingEach { top = 20, bottom = 20, left = 0, right = 0 }, width fill ]
        [ Element.column
            [ centerX
            , centerY
            , Font.center
            , width <| px <| 800
            , Background.color theme.contentBgColor
            , rounded 10
            , padding 20
            ]
            [ viewTitle page.title
            , Element.el [ Font.alignLeft ] (Element.html (Markdown.toHtmlWith markdownOptions [ Html.Attributes.style "white-space" "normal", Html.Attributes.style "line-height" "30px" ] page.content))
            ]
        ]


viewHeader : Display -> Element Msg
viewHeader display =
    Element.row [ centerY, Font.size 25, spaceEvenly, Font.light, Font.alignRight, width fill, alignRight, height <| px <| 70 ]
        [ viewFilterButtons display
        , viewSiteTitle
        , viewHeaderLinks
        ]


viewFilterButtons : Display -> Element Msg
viewFilterButtons display =
    Element.row [ spacing 20 ]
        [ displayHeaderButton "音" (DisplayBy ListByKanaRow) display
        , displayHeaderButton "なし" (DisplayBy NoCategories) display
        , displayHeaderButton "混合" (DisplayBy NoCategories) display
        ]


viewHeaderLinks : Element Msg
viewHeaderLinks =
    Element.row [ spacing 20, alpha 0.3 ]
        (List.map
            (\p -> viewHeaderLink p.title (Routes.getUrlFromRoute p.route))
            pages
        )


displayHeaderButton : String -> Msg -> Display -> Element Msg
displayHeaderButton label action display =
    case display of
        NoCategories ->
            case action of
                DisplayBy NoCategories ->
                    viewInactiveHeaderButton label

                _ ->
                    viewHeaderButton label action FilterButton

        ListByKanaRow ->
            case action of
                DisplayBy ListByKanaRow ->
                    viewInactiveHeaderButton label

                _ ->
                    viewHeaderButton label action FilterButton


type HeaderButtonType
    = FilterButton
    | LinkButton


viewHeaderButton : String -> Msg -> HeaderButtonType -> Element Msg
viewHeaderButton label action buttonType =
    let
        ( bg, bgHover ) =
            case buttonType of
                FilterButton ->
                    ( theme.buttonBgColor, theme.buttonBgHover )

                LinkButton ->
                    ( theme.buttonBgColorAlt, theme.buttonBgHoverAlt )
    in
    button
        [ Background.color bg
        , rounded 10
        , padding 15
        , Font.size 18
        , Font.center
        , mouseOver [ Background.color bgHover, Font.color theme.fontColorLighter ]
        ]
        { label = Element.text label
        , onPress = Just action
        }


viewHeaderLink : String -> String -> Element Msg
viewHeaderLink label url =
    Element.link
        [ Background.color theme.buttonBgColorAlt
        , rounded 10
        , padding 15
        , Font.size 18
        , Font.center
        , mouseOver [ Background.color theme.buttonBgHoverAlt, Font.color theme.fontColorLighter ]
        ]
        { label = Element.text label
        , url = url
        }


viewInactiveHeaderButton : String -> Element Msg
viewInactiveHeaderButton label =
    Element.el
        [ Background.color theme.buttonBgColor
        , rounded 10
        , padding 15
        , Font.size 18
        , Font.center
        , alpha 0.75
        ]
        (Element.text label)


viewSiteTitle : Element Msg
viewSiteTitle =
    Element.text "漢字の音学ぶ教室へようこそ！！"


viewTitle : String -> Element Msg
viewTitle title =
    Element.el [ Font.extraLight, Font.size 50, paddingEach { top = 20, bottom = 20, right = 0, left = 10 } ] (Element.text title)


viewSoundComponents : List SoundComponent -> List SoundComponent -> Element Msg
viewSoundComponents selected soundComponents =
    Element.wrappedRow
        [ spacing 20
        , width fill
        ]
        (List.map (viewSoundComponent selected) soundComponents)


viewSoundComponentsByKana : List SoundComponent -> List SoundComponent -> Element Msg
viewSoundComponentsByKana selected soundComponents =
    Element.column
        [ spacing 20
        , width fill
        ]
        (List.map (\kanaRow -> viewKanaRow kanaRow selected soundComponents) allKanaRows)


viewSoundComponent : List SoundComponent -> SoundComponent -> Element Msg
viewSoundComponent selected soundComponent =
    if List.any (\selectedComponent -> selectedComponent == soundComponent) selected then
        viewSelectedSoundComponent soundComponent

    else
        viewUnselectedSoundComponent soundComponent


viewUnselectedSoundComponent : SoundComponent -> Element Msg
viewUnselectedSoundComponent soundComponent =
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
                [ Element.el [ Font.center, centerX, centerY ] (text (String.fromChar soundComponent.component))
                ]
        , onPress = Just (SelectSoundComponent soundComponent)
        }


viewSelectedSoundComponent : SoundComponent -> Element Msg
viewSelectedSoundComponent soundComponent =
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
                [ Element.el [ Font.center, centerX, centerY ] (text soundComponent.sound)
                , Element.el [ Font.center, centerX, centerY, Font.size 20, alpha 0.3 ] (text (String.fromChar soundComponent.component))
                ]
        , onPress = Just (DeselectSoundComponent soundComponent)
        }


viewKanaRow : KanaRow -> List SoundComponent -> List SoundComponent -> Element Msg
viewKanaRow kanaRow selected soundComponents =
    Element.column [ paddingEach { top = 10, bottom = 20, left = 0, right = 0 } ]
        [ viewTitle (printKanaRowInKana kanaRow)
        , Element.wrappedRow
            [ spacing 20
            , width fill
            ]
            (List.map (viewSoundComponent selected) (List.filter (\soundComponent -> isSoundFromKanaRow kanaRow soundComponent) soundComponents))
        ]


allKanaRows : List KanaRow
allKanaRows =
    [ AIUEO
    , KAKIKUKEKO
    , SASHISUSESO
    , TACHITSUTETO
    , NANINUNENO
    , HAHIFUHEHO
    , MAMIMUMEMO
    , YAYUYO
    , RARIRURERO
    , WAWO
    , N
    ]


isSoundFromKanaRow : KanaRow -> SoundComponent -> Bool
isSoundFromKanaRow kanaRow soundComponent =
    let
        startsWith =
            String.split "" (printKanaRowInKana kanaRow)
    in
    List.any (\letter -> String.startsWith letter soundComponent.sound) startsWith


viewPopup : SoundComponent -> Element Msg
viewPopup soundComponent =
    Element.column
        [ width fill
        , height fill
        , alpha 0.95
        , Background.color theme.bgColor
        , Element.inFront (viewSelectedSoundComponent soundComponent)
        ]
        []


viewSoundComponentAttribute : String -> String -> Element Msg
viewSoundComponentAttribute attribute value =
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
