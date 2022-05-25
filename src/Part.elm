module Part exposing (..)


getJapanesePartName : Part -> String
getJapanesePartName part =
    case part of
        Left ->
            "へん"

        Right ->
            "つくり"

        Top ->
            "かんむり"

        Bottom ->
            "あし"

        Enclose ->
            "かまえ"

        Hang ->
            "たれ"

        Wrap ->
            "にょう"

        None ->
            "なし"


type Part
    = Left
    | Right
    | Top
    | Bottom
    | Enclose
    | Hang
    | Wrap
    | None


all : List Part
all =
    [ Left
    , Right
    , Top
    , Bottom
    , Enclose
    , Hang
    , Wrap
    , None
    ]
