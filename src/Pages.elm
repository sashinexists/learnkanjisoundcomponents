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
こんにちは、サシンです。僕がこのアプリの作者です。
漢字の部首を学ぶためにこのアプリを作りました。

## 部首とは何でしょうか？
部首は漢字の部分です。

例えば、

休みの「休」は人と木でできています。

> 休

木の近くに座っている人の姿から漢字が作られました。

そして、人と木はこの漢字の部首になります。

部首を知っていれば、新しい漢字を学ぶのは簡単です。

"""


pages : List Page
pages =
    [ about, support ]
