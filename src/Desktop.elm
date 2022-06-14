module Desktop exposing (view)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border exposing (rounded)
import Element.Font as Font
import Element.Input exposing (button)
import Html.Attributes
import Kana exposing (KanaRow(..), printKanaRowInKana)
import Markdown
import Pages exposing (Page, pages)
import Routes exposing (Route(..))
import Shared exposing (Display(..), Model, Msg(..))
import SoundComponent exposing (SoundComponent)
import Theme exposing (..)


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



-- this is for when you have about / support pages again


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
    let
        styles =
            [ centerY, Font.size 25, spaceEvenly, Font.light, Font.alignRight, width fill, alignRight, height <| px <| 70 ]

        content =
            [ viewFilterButtons display
            , viewSiteTitle
            , viewHeaderLinks
            ]
    in
    Element.row styles content


viewFilterButtons : Display -> Element Msg
viewFilterButtons display =
    Element.row [ spacing 20 ]
        [ displayHeaderButton "音" (DisplayBy ListByKanaRow) display
        , displayHeaderButton "なし" (DisplayBy NoCategories) display
        , displayHeaderButton "混合" Randomise display
        ]


viewHeaderLinks : Element Msg
viewHeaderLinks =
    Element.row [ spacing 20, alpha 0 ]
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
            Element.row [ Font.center, centerX, centerY, spacing 20 ]
                [ Element.el [ Font.center, centerX, centerY ] (text soundComponent.sound)
                , Element.el [ Font.center, Font.extraLight, centerX, centerY, alpha 0.3 ] (text (String.fromChar soundComponent.component))
                ]
        , onPress = Just (DeselectSoundComponent soundComponent)
        }


viewKanaRow : KanaRow -> List SoundComponent -> List SoundComponent -> Element Msg
viewKanaRow kanaRow selected soundComponents =
    if List.any (isSoundFromKanaRow kanaRow) soundComponents then
        Element.column [ paddingEach { top = 10, bottom = 20, left = 0, right = 0 } ]
            [ viewTitle (printKanaRowInKana kanaRow)
            , Element.wrappedRow
                [ spacing 20
                , width fill
                ]
                (List.map (viewSoundComponent selected) (List.filter (\soundComponent -> isSoundFromKanaRow kanaRow soundComponent) soundComponents))
            ]

    else
        Element.text ""


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
