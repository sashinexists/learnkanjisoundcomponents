module Radical exposing (Radical)

import Meaning exposing (Meaning)
import Part exposing (Part)
import Subject exposing (Subject)


type alias Radical =
    { radical : Char
    , name : String
    , meaning : Meaning
    , alternates : List Char
    , part : Part
    , examples : List Char
    , subject : Subject
    }
