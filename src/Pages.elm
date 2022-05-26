module Pages exposing (..)

import Routes exposing (Route(..))


type alias Page =
    { title : String
    , content : String
    , route : Route
    }


about : Page
about =
    { title = "このアプリでついて"
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
<iframe src="https://donorbox.org/embed/sashinexists" name="donorbox" allowpaymentrequest="allowpaymentrequest" seamless="seamless" frameborder="0" scrolling="no" height="900px" width="100%" style="max-width: 500px; min-width: 250px; max-height:none!important"></iframe>
    """


aboutCopy : String
aboutCopy =
    """

# TestKanji and functional components
- All kanji are made up of what are called functional components
- Basically they are made up of smaller parts - or components - and understanding what they are made up of can tell you how the Kanji is pronounced and what they mean
- Every component has a meaning associated with it as well as a pronunciation
- In most kanji there is one component within it that tells you how it is pronounced, it’s “sound component” as well as one or more that tell you what it means, the “semantic components”
- Semantic components in turn are divided into form components and meaning components
\t- with form components how the component looks like will inform the meaning of the kanji, with meaning it will be what the component means
- empty components are components that do neither of these things they tend to be “differentiators” or “corruptions”
\t- 王
\t- 玉
\t- so above is “king” and “ball” the little dash is a “differentiator” it doesn’t mean anything by itself, it simply differentiates the kanji from king
\t- corruptions are like the chinese whispers of kanji, it’s when the original component was misinterpreted when adapted to modern kanji - so it no longer is meaningful in its current form
- Understanding the functional components helps create meaningful mnemonics and as the components are reused it makes it progressively easier to learn new kanji
- Actually understanding how kanji works is supposed to make them easier to remember
"""


pages : List Page
pages =
    [ about, support ]
