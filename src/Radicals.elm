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
    ]
