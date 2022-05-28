module Pages exposing (..)

import Routes exposing (Route(..))


type alias Page =
    { title : String
    , content : String
    , route : Route
    }


about : Page
about =
    { title = "このアプリについて"
    , content = aboutCopy
    , route = About
    }


support : Page
support =
    { title = "❤"
    , content = supportCopy
    , route = Support
    }


supportCopy : String
supportCopy =
    """# About Learning Japanese
        
<a href="https://donorbox.org/sashinexists">Donate Text or Image HTML</a>
    """


aboutCopy : String
aboutCopy =
    """
こんにちは、サシンです。このアプリの作ったものですよ。
このアプリは漢字の部首を学ぶために作ったんでした。

## 漢字の部首はなんですか


## どうして部首を学びますか
"""


pages : List Page
pages =
    [ about, support ]
