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
## Why I Am Learning Japanese
You wrote about your reasons for learning in Japanese in your piece; [Learning and Language](https://sashinexists.com/letter/learning-and-language)

In short those reasons are:

1. To untether my thinking from the conventions of the English language
2. To learn more about learning itself
3. To understand more about our culture
4. To read One Piece in Japanese (actual reason)

I want to become fluent in Japanese. I want to develop a better theory of learning, understanding and memory that I can go on to apply to other things. I want to understand more about language influences and even shapes our thinking and the ideas in George Orwell’s 1984’s “Newspeak” and Ted Chiang’s short stories have any credence.

I want to better get a handle on following the fun criterion and how living in a way in alignment with it I can accomplish feats most would consider difficult.

---
## Finite Pieces to the Language
When studying Japanese, Tim Ferris experienced a turning point when he put up a poster of all two thousand Joyo Kanji up on the wall. It was a monumental task, but it was a finite one; there were only so many things to do.

As I can see from here, there are really only two types of things I need to learn explicitly.

1. Kanji and Vocabulary: What the symbols and words mean and how they are pronounced
2. Structure/Grammar: how they fit together to convey information

There are only two thousand joyo kanji, there are many more words but they are made up of the kanji and thus easier to remember.

There also seem to be finite grammar points. When learning Japanese these are divided into five levels from N5 to N1, from most common use to least.

There are only so many steps to learn what they are, how they work and to then intuit them.

A bonus is learning more and more about this process itself which can then be applied to other languages - and even other domains altogether.

---
## The Organic Method
The method of acquiring the language that makes the most sense to me is the Organic Method pioneered by [Cure Dolly’s Organic Japanese].

Immersion is central here, but unlike the AJATT method the comprehensibility of the input is stressed to be of utmost importance.

In the organic method the learner explicitly the minimum required to start to consume Japanese content (typically hiragana and katakana) and jumps right in. New Vocabulary and Kanji are learned from the material itself, with the structure of the language learned explicitly concurrently with the immersion.

The workflow looks like this:

1. Immerse in Japanese material, looking up words and creating flashcards from them
2. Every day review the flashcards adding a few to your deck each day
3. When cooking, cleaning, going on walks throughout the day listen to the audio of the already parsed material
    """


aboutCopy : String
aboutCopy =
    """

# Kanji and functional components
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
