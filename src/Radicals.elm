module Radicals exposing (radicals)

import Meaning exposing (..)
import Part exposing (..)
import Radical exposing (Radical)
import Subject exposing (..)


radicals : List Radical
radicals =
    [ Radical '水' "みず" Same [ '氵' ] None [] Nature
    , Radical '氵' "さんずい" (Different "水") [ '水' ] None [] Nature
    , Radical '木' "き" Same [] None [] Nature
    , Radical '土' "つち" Same [] None [] Nature
    , Radical '日' "ひ" Same [] None [] Nature
    , Radical '艸' "くさ" Same [ '艹' ] None [] Nature
    , Radical '艹' "くさかんむり" (Different "草") [ '艸' ] Top [] Nature
    , Radical '火' "ひ" Same [ '灬' ] None [] Nature
    , Radical '灬' "れっか" (Different "火") [ '火' ] Bottom [] Nature
    , Radical '田' "た" Same [] None [] Nature
    , Radical '貝' "かい" Same [] None [] Nature
    , Radical '頁' "おおがい" Same [] Right [] Nature
    , Radical '月' "つき" Same [] None [] Nature
    , Radical '石' "いし" Same [] None [] Nature
    , Radical '川' "さんぼんがわ" (Different "かわ") [] None [] Nature
    , Radical '山' "やま" Same [] None [] Nature
    , Radical '雨' "あめ" Same [] None [] Nature
    , Radical '⽓' "きがまえ" (Different "蒸気") [] Enclose [] Nature
    , Radical '冫' "にすい" (Different "氷・二つの水度") [] Left [] Nature
    , Radical '穴' "あな" (Different "洞窟・穴") [] None [] Nature
    , Radical '谷' "たに" Same [] None [] Nature
    , Radical '支' "しにょう" (Different "枝") [] None [] Nature
    , Radical '口' "くち" Same [] None [] BodyParts
    , Radical '手' "て" Same [ '扌' ] None [] BodyParts
    , Radical '扌' "てへん" (Different "手") [ '手' ] None [] BodyParts
    , Radical '心' "こころ" Same [ '⺗', '⺖' ] None [] BodyParts
    , Radical '⺗' "したごころ" (Different "心") [ '心', '⺖' ] Bottom [] BodyParts
    , Radical '⺖' "りっしんべん" (Different "心") [ '心', '⺗' ] Left [] BodyParts
    , Radical '肉' "にく" Same [ '月' ] None [] BodyParts
    , Radical '月' "にくづき" Same [] None [] BodyParts
    , Radical '目' "め" Same [] None [] BodyParts
    , Radical '儿' "ひとあし" Same [] Bottom [] BodyParts
    , Radical '欠' "あくび" Same [] None [] BodyParts
    , Radical '尸' "しかばね" (Different "死体") [] Hang [] BodyParts
    , Radical '癶' "はつがしら" (Different "足音") [] Top [] BodyParts
    , Radical '足' "あし" Same [] None [] BodyParts
    , Radical '首' "くび" Same [] None [] BodyParts
    , Radical '身' "み" Same [] None [] BodyParts
    , Radical '皮' "けがわ" (Different "肌") [] None [] BodyParts
    , Radical '彡' "さんづくり" (Different "髪・三") [] Right [] BodyParts
    , Radical '血' "ち" Same [] None [] BodyParts
    , Radical '歯' "は" Same [] None [] BodyParts
    , Radical '人' "ひと" Same [ '亻', '𠆢' ] None [] People
    , Radical '亻' "にんべん" (Different "人") [ '人', '𠆢' ] Left [] People
    , Radical '𠆢' "ひとやね" (Different "人") [ '人', '亻' ] Top [] People
    , Radical '女' "おんな" Same [] None [] People
    , Radical '雨' "あめ" Same [] None [] People
    , Radical '老' "おいかんむり" (Different "お年寄り") [ '耂' ] None [] People
    , Radical '耂' "おいかんむり" (Different "お年寄り") [ '老' ] Top [] People
    , Radical '王' "おう" Same [] None [] People
    , Radical '⽟' "たま" Same [] None [] People
    , Radical '子' "こ" Same [] None [] People
    , Radical '氏' "うし" (Different "家族の名前") [] None [] People
    , Radical '士' "さむらい" Same [] None [] People
    , Radical '臣' "しん" (Different "政府の役人") [] None [] People
    , Radical '自' "みずから" (Different "自分") [] None [] People
    , Radical '己' "おのれ" Same [] None [] People
    , Radical 'ム' "む" (Different "民間・カタカナのム") [] None [] People
    , Radical '辶' "しんにょう" (Different "動き・歩く・進む") [] Wrap [] Enclosures
    , Radical '疒' "やまいだれ" (Different "病気") [] Hang [] Enclosures
    , Radical '⼴' "まだれ" (Different "屋上") [] Hang [] Enclosures
    , Radical '彳' "ぎょうにんべん" (Different "歩") [] Left [] Enclosures
    , Radical '阝' "こざとへん" (Different "左の村") [] Left [] Enclosures
    , Radical '阝' "おおざと" (Different "右の村") [] Right [] Enclosures
    , Radical '囗' "くにがまえ" (Different "国境") [] Enclose [] Enclosures
    , Radical '門' "もんがまえ" (Different "もん") [] Enclose [] Enclosures
    , Radical '宀' "う かんむり" (Different "屋上・カタカナのゥ") [] Top [] Enclosures
    , Radical '亠' "なべぶた" Same [] Top [] Enclosures
    , Radical '廴' "えんにょう" (Different "伸ばす・長いステップ") [] Wrap [] Enclosures
    , Radical '⼚' "がんだれ" (Different "崖") [] Hang [] Enclosures
    , Radical '勹' "つつみがまえ" (Different "包装") [] Enclose [] Enclosures
    , Radical '⼐' "かんにょう" (Different "受け箱") [] Wrap [] Enclosures
    , Radical '匚' "はこがまえ" (Different "箱") [] Enclose [] Enclosures
    , Radical '丶' "てん" Same [] None [] Enclosures
    , Radical '⺍' "つ かんむり" (Different "カタカナのツ") [] Top [] Enclosures
    , Radical '冖' "わかんむり" (Different "覆う・冠") [] Top [] Enclosures
    , Radical '丿' "の" (Different "カタカナのノ") [] None [] Enclosures
    , Radical '亅' "はねぼう" (Different "釣り針") [] None [] Enclosures
    , Radical '言' "げん" (Different "話している") [] None [] VerbsAndLanguage
    , Radical '食' "しょく" Same [ '飠' ] None [] VerbsAndLanguage
    , Radical '飠' "しょくへん" (Different "食べ物") [ '食' ] Left [] VerbsAndLanguage
    , Radical '示' "しめす" Same [ '礻' ] None [] VerbsAndLanguage
    , Radical '礻' "しめすへん" (Different "示す") [ '示' ] Left [] VerbsAndLanguage
    , Radical '又' "また" (Different "また・右の手") [] None [] VerbsAndLanguage
    , Radical '立' "たつ" Same [] None [] VerbsAndLanguage
    , Radical '止' "とめる" Same [] None [] VerbsAndLanguage
    , Radical '工' "たくみ" (Different "働く・カタカナのエ") [] None [] VerbsAndLanguage
    , Radical '⾒' "みる" Same [] None [] VerbsAndLanguage
    , Radical '走' "はしる" Same [] None [] VerbsAndLanguage
    , Radical '干' "かん" (Different "干した") [] None [] VerbsAndLanguage
    , Radical '曰' "ひらび" (Different "言う") [] None [] VerbsAndLanguage
    , Radical '比' "くらべる" Same [] None [] VerbsAndLanguage
    , Radical '生' "うまれる" (Different "うまれる・住む") [] None [] VerbsAndLanguage
    , Radical '非' "あらず" (Different "違う・反対・カタカナのヒ") [] None [] VerbsAndLanguage
    , Radical '⾏' "ぎょうがまえ" (Different "いく") [] Enclose [] VerbsAndLanguage
    , Radical '竹' "たけ" Same [] None [] NaturalMaterials
    , Radical '糸' "いと" Same [ '幺' ] None [] NaturalMaterials
    , Radical '幺' "いとへん" (Different "織物") [ '糸' ] Left [] NaturalMaterials
    , Radical '金' "かね" Same [] None [] NaturalMaterials
    , Radical '巾' "はば" (Different "布") [] None [] NaturalMaterials
    , Radical '衣' "ころも" Same [ '衤' ] None [] NaturalMaterials
    , Radical '衤' "ころもへん" (Different "衣服") [ '衣' ] Left [] NaturalMaterials
    , Radical '麻' "あさ" Same [] None [] NaturalMaterials
    , Radical '韋' "なめしがわ" (Different "鞣皮") [] None [] NaturalMaterials
    , Radical '⽦' "ひき" Same [ '⺪' ] None [] NaturalMaterials
    , Radical '⺪' "ひきへん" (Different "⽦") [ '⽦' ] Left [] NaturalMaterials
    , Radical '一' "いち" (Different "一つ") [] None [] MathAndMeasurement
    , Radical '二' "に" (Different "二つ") [] None [] MathAndMeasurement
    , Radical '八' "はち" (Different "八つ") [] None [] MathAndMeasurement
    , Radical '十' "じゅう" (Different "十つ") [] None [] MathAndMeasurement
    , Radical '寸' "すん" Same [] None [] MathAndMeasurement
    , Radical '大' "だい" (Different "大きい") [] None [] MathAndMeasurement
    , Radical '小' "しょう" (Different "小さい") [] None [] MathAndMeasurement
    , Radical '長' "ながい" Same [ '镸' ] None [] MathAndMeasurement
    , Radical '镸' "ながいへん" (Different "長い") [ '長' ] Left [] MathAndMeasurement
    , Radical '高' "たかい" Same [] None [] MathAndMeasurement
    , Radical '乙' "おつ" Same [ '乚' ] None [] MathAndMeasurement
    , Radical '乚' "おつ" (Different "乙") [ '乙' ] None [] MathAndMeasurement
    , Radical '片' "かた" (Different "切った木") [] None [] MathAndMeasurement
    , Radical '釆' "のごめ" (Different "分割する") [] None [] MathAndMeasurement
    , Radical '面' "めん" (Different "面") [] None [] MathAndMeasurement
    , Radical '方' "ほう" (Different "方向") [] None [] MathAndMeasurement
    , Radical '西' "にし" Same [ '⾑', '⻃' ] None [] MathAndMeasurement
    , Radical '⾑' "にしへん" (Different "西") [ '西', '⻃' ] None [] MathAndMeasurement
    , Radical '⻃' "にしへん" (Different "西") [ '西', '⾑' ] None [] MathAndMeasurement
    , Radical '艮' "こん" (Different "境界") [] None [] MathAndMeasurement
    , Radical '斉' "せい" (Different "らしい") [] None [] MathAndMeasurement
    , Radical '夂' "ふゆ がしら" (Different "冬") [] None [] MathAndMeasurement
    , Radical '⼣' "ゆうべ" (Different "夕べ") [] None [] MathAndMeasurement
    , Radical '米' "こめ" Same [] None [] Food
    , Radical '禾' "のぎへん" (Different "粒") [] Left [] Food
    , Radical '皿' "さら" Same [] None [] Food
    , Radical '匕' "さじのひ" (Different "匙") [] Right [] Food
    , Radical '酉' "ひよみのとり" (Different "酒") [] None [] Food
    , Radical '麦' "むぎ" Same [] None [] Food
    , Radical '豆' "まめ" Same [] None [] Food
    , Radical '馬' "うま" Same [] None [] Animals
    ]
