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

## 漢字の部首はなんですか？
部首は漢字の部分です。

例えば。

休みの休は人と木もあります。

> 休

この漢字の形は木の近くに人は座っています。

ここで人と木は漢字の部首ですよ。

部首を知ってた人だったら新しい漢字を学ぶのは簡単ですよ。

## どうして部首を学びますか？

## 菜多梨さん、ありがとうございます！！

## 僕は誰ですか？

"""


pages : List Page
pages =
    [ about, support ]
