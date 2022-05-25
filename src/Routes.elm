module Routes exposing (..)


type Route
    = Home
    | About
    | Support


getUrlFromRoute : Route -> String
getUrlFromRoute route =
    case route of
        Home ->
            "/"

        About ->
            "/about"

        Support ->
            "/support"
