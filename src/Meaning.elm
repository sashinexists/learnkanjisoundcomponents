module Meaning exposing (..)


type Meaning
    = Same
    | Different String

displayMeaning : Meaning -> String
displayMeaning meaning = 
    case meaning of
        Same -> "名前の同じ"
        Different m -> m