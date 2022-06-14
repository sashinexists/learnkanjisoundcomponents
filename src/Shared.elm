module Shared exposing (..)

import Browser
import Browser.Dom as Dom exposing (Viewport)
import Browser.Navigation as Nav
import Element exposing (Device)
import Routes exposing (..)
import SoundComponent exposing (..)
import Url exposing (Url)


type alias Model =
    { key : Nav.Key
    , url : Url
    , soundComponents : List SoundComponent
    , selected : List SoundComponent
    , display : Display
    , route : Route
    , device : Device
    }


type Display
    = ListByKanaRow
    | NoCategories


type Msg
    = SelectSoundComponent SoundComponent
    | DeselectSoundComponent SoundComponent
    | UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | DisplayBy Display
    | NewSoundComponentsList (List SoundComponent)
    | Randomise
    | KeyDown String
    | WindowResized Int Int
    | GotViewport Viewport
