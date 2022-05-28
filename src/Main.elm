module Main exposing (..)

import Browser
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Border exposing (roundEach, rounded)
import Element.Font as Font
import Element.Input exposing (button)
import Html.Attributes
import Json.Decode as D
import Markdown
import Meaning exposing (displayMeaning)
import Pages exposing (..)
import Part exposing (Part, getJapanesePartName)
import Radical exposing (Radical)
import Radicals exposing (radicals)
import Routes exposing (Route(..))
import Subject exposing (Subject, getJapaneseSubjectName)
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
    = ListBySubject
    | ListByPart
    | NoCategories


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        model =
            { key = key
            , url = url
            , radicals = radicals
            , selected = Nothing
            , display = ListBySubject
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
    = SelectRadical Radical
    | DeselectRadical
    | UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | DisplayBy Display
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

        SelectRadical radical ->
            ( { model | selected = Just radical }
            , Cmd.none
            )

        DeselectRadical ->
            deselectRadical model

        KeyDown key ->
            handleKeyDown key model

        DisplayBy option ->
            ( { model | display = option, route = Home }, Cmd.none )


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
            (Element.column [ paddingEach { top = 10, bottom = 10, left = 60, right = 50 }, width fill ]
                [ viewHeader model.display
                , case model.route of
                    Home ->
                        viewHomeRoute model

                    About ->
                        viewPage Pages.about

                    Support ->
                        viewPage Pages.support
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
            ListBySubject ->
                viewRadicalsBySubject model.radicals

            ListByPart ->
                viewRadicalsByPart model.radicals

            NoCategories ->
                viewRadicals model.radicals
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
        [ displayHeaderButton "主題" (DisplayBy ListBySubject) display
        , displayHeaderButton "部分" (DisplayBy ListByPart) display
        , displayHeaderButton "全部" (DisplayBy NoCategories) display
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
        ListBySubject ->
            case action of
                DisplayBy ListBySubject ->
                    viewInactiveHeaderButton label

                _ ->
                    viewHeaderButton label action FilterButton

        ListByPart ->
            case action of
                DisplayBy ListByPart ->
                    viewInactiveHeaderButton label

                _ ->
                    viewHeaderButton label action FilterButton

        NoCategories ->
            case action of
                DisplayBy NoCategories ->
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
    Element.text "漢字の部首学ぶ教室へようこそ！！"


viewTitle : String -> Element Msg
viewTitle title =
    Element.el [ Font.extraLight, Font.size 50, paddingEach { top = 20, bottom = 20, right = 0, left = 10 } ] (Element.text title)


viewRadicals : List Radical -> Element Msg
viewRadicals radicals =
    Element.wrappedRow
        [ spacing 20
        , width fill
        ]
        (List.map viewRadical radicals)


viewRadicalsBySubject : List Radical -> Element Msg
viewRadicalsBySubject radicals =
    Element.column []
        (List.map
            (viewSubjectRadicals radicals)
            Subject.all
        )


viewRadicalsByPart : List Radical -> Element Msg
viewRadicalsByPart radicals =
    Element.column []
        (List.map
            (viewPartRadicals radicals)
            Part.all
        )


viewSubjectRadicals : List Radical -> Subject -> Element Msg
viewSubjectRadicals radicals subject =
    Element.column [ paddingEach { top = 10, bottom = 20, left = 0, right = 0 } ]
        [ viewTitle (getJapaneseSubjectName subject)
        , Element.wrappedRow
            [ spacing 20
            , width fill
            ]
            (List.map viewRadical (List.filter (\r -> r.subject == subject) radicals))
        ]


viewPartRadicals : List Radical -> Part -> Element Msg
viewPartRadicals radicals part =
    Element.column [ paddingEach { top = 10, bottom = 20, left = 0, right = 0 } ]
        [ viewTitle (getJapanesePartName part)
        , Element.wrappedRow
            [ spacing 20
            , width fill
            ]
            (List.map viewRadical (List.filter (\r -> r.part == part) radicals))
        ]


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
