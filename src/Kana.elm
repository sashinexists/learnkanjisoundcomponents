module Kana exposing (KanaRow(..), printKanaRowInKana)


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
