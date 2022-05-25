module Subject exposing (..)


getJapaneseSubjectName : Subject -> String
getJapaneseSubjectName subject =
    case subject of
        Nature ->
            "自然"

        BodyParts ->
            "身体部位"

        People ->
            "人"

        Enclosures ->
            "環境"

        VerbsAndLanguage ->
            "動詞と言語"

        NaturalMaterials ->
            "自然材料"

        MathAndMeasurement ->
            "数学と測定"

        Food ->
            "食物"

        Animals ->
            "動物"

        Warfare ->
            "戦争"

        ManMadeTools ->
            "人間製のツール"

        --can improve this
        Senses ->
            "感覚"

        Supernatural ->
            "超自然"



--can improve this


type Subject
    = Nature
    | BodyParts
    | People
    | Enclosures
    | VerbsAndLanguage
    | NaturalMaterials
    | MathAndMeasurement
    | Food
    | Animals
    | Warfare
    | ManMadeTools
    | Senses
    | Supernatural


all : List Subject
all =
    [ Nature
    , BodyParts
    , People
    , Enclosures
    , VerbsAndLanguage
    , NaturalMaterials
    , MathAndMeasurement
    , Food
    , Animals
    , Warfare
    , ManMadeTools
    , Senses
    , Supernatural
    ]
