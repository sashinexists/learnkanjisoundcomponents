module Pages exposing (..)

import Markdown
import Routes exposing (Route(..))


type alias Page =
    { title : String
    , content : String
    , route : Route
    }


about : Page
about =
    { title = "ついて"
    , content = "This is the about page"
    , route = About
    }


support : Page
support =
    { title = "❤"
    , content = """

# Apple Pie Recipe

First, invent the universe. Then bake an apple pie.

"""
    , route = Support
    }


pages : List Page
pages =
    [ about, support ]
