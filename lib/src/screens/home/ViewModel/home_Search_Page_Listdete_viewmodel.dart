import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//条件タブのためのクラス
class ConditionTab with ChangeNotifier {
// 条件のリスト
  final List<String> conditionsList = [
    '辛さ',
    '価格',
    '評価',
    '店舗タイプ',
    '営業時間',
    '定休日',
    'アクセス',
  ];
}

//検索タブのためのクラス
class SearchTab with ChangeNotifier {
  static const List<String> regionsList = [
    //地域のリスト

    '関東',
    '北海道・東北',
    '北陸・甲信越',
    '東海',
    '近畿',
    '中国・四国',
    '九州・沖縄',
  ];

  static const Map<String, List<Map<String, dynamic>>> prefectureList = {
    '関東': [
      {'value': '東京都', 'checked': false},
      {'value': '神奈川県', 'checked': false},
      {'value': '千葉県', 'checked': false},
      {'value': '埼玉県', 'checked': false},
      {'value': '茨城県', 'checked': false},
      {'value': '栃木県', 'checked': false},
      {'value': '群馬県', 'checked': false},
    ],
    '北海道・東北': [
      {'value': '北海道', 'checked': false},
      {'value': '青森県', 'checked': false},
      {'value': '岩手県', 'checked': false},
      {'value': '宮城県', 'checked': false},
      {'value': '秋田県', 'checked': false},
      {'value': '山形県', 'checked': false},
      {'value': '福島県', 'checked': false},
    ],
    '北陸・甲信越': [
      {'value': '新潟県', 'checked': false},
      {'value': '富山県', 'checked': false},
      {'value': '石川県', 'checked': false},
      {'value': '福井県', 'checked': false},
      {'value': '山梨県', 'checked': false},
      {'value': '長野県', 'checked': false},
      {'value': '岐阜県', 'checked': false},
      {'value': '静岡県', 'checked': false},
    ],
    '東海': [
      {'value': '愛知県', 'checked': false},
      {'value': '岐阜県', 'checked': false},
      {'value': '静岡県', 'checked': false},
      {'value': '三重県', 'checked': false},
    ],
    '近畿': [
      {'value': '大阪府', 'checked': false},
      {'value': '兵庫県', 'checked': false},
      {'value': '京都府', 'checked': false},
      {'value': '滋賀県', 'checked': false},
      {'value': '奈良県', 'checked': false},
      {'value': '和歌山県', 'checked': false},
    ],
    '中国・四国': [
      {'value': '鳥取県', 'checked': false},
      {'value': '島根県', 'checked': false},
      {'value': '岡山県', 'checked': false},
      {'value': '広島県', 'checked': false},
      {'value': '山口県', 'checked': false},
      {'value': '徳島県', 'checked': false},
      {'value': '香川県', 'checked': false},
      {'value': '愛媛県', 'checked': false},
      {'value': '高知県', 'checked': false},
    ],
    '九州・沖縄': [
      {'value': '福岡県', 'checked': false},
      {'value': '佐賀県', 'checked': false},
      {'value': '長崎県', 'checked': false},
      {'value': '熊本県', 'checked': false},
      {'value': '大分県', 'checked': false},
      {'value': '宮崎県', 'checked': false},
      {'value': '鹿児島県', 'checked': false},
      {'value': '沖縄県', 'checked': false},
    ],
  };

//沿線のリスト
  static const Map<String, List<Map<String, dynamic>>> railwayList = {
    '東京都': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '東京メトロ', 'checked': false},
      {'value': '都営地下鉄', 'checked': false},
      {'value': '京王電鉄', 'checked': false},
      {'value': '東急電鉄', 'checked': false},
    ],
    '神奈川県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '相鉄', 'checked': false},
      {'value': '小田急電鉄', 'checked': false},
      {'value': '京急電鉄', 'checked': false},
    ],
    '千葉県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '京成電鉄', 'checked': false},
      {'value': '東京メトロ', 'checked': false},
      {'value': 'つくばエクスプレス', 'checked': false},
    ],
    '埼玉県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '埼玉高速鉄道', 'checked': false},
      {'value': '東武鉄道', 'checked': false},
      {'value': '西武鉄道', 'checked': false},
    ],
    '茨城県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '関東鉄道', 'checked': false},
      {'value': 'つくばエクスプレス', 'checked': false},
    ],
    '栃木県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '東武鉄道', 'checked': false},
      {'value': '日光線', 'checked': false},
      {'value': '鬼怒川線', 'checked': false},
    ],
    '群馬県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '上越新幹線', 'checked': false},
      {'value': '関越自動車道', 'checked': false},
    ],
    '北海道': [
      {'value': 'JR北海道', 'checked': false},
      {'value': '函館市電', 'checked': false},
      {'value': '札幌市営地下鉄', 'checked': false},
      {'value': '札幌市電', 'checked': false},
      {'value': '函館市電', 'checked': false},
    ],
    '青森県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '青い森鉄道', 'checked': false},
      {'value': '南部縦貫鉄道', 'checked': false},
    ],
    '岩手県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '岩手県交通', 'checked': false},
      {'value': '盛岡市営バス', 'checked': false},
      {'value': '釜石線', 'checked': false},
    ],
    '秋田県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '秋田内陸縦貫鉄道', 'checked': false},
      {'value': '秋田市営バス', 'checked': false},
      {'value': '秋田空港', 'checked': false},
    ],
    '山形県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '山形新幹線', 'checked': false},
      {'value': '山形駅前線', 'checked': false},
      {'value': '山交バス', 'checked': false},
    ],
    '福島県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '東北新幹線', 'checked': false},
      {'value': '会津鉄道', 'checked': false},
      {'value': '福島交通', 'checked': false},
    ],
    '新潟県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '上越新幹線', 'checked': false},
      {'value': '信越本線', 'checked': false},
      {'value': 'えちごトキめき鉄道', 'checked': false},
    ],
    '富山県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': 'JR東海', 'checked': false},
      {'value': 'あいの風とやま鉄道', 'checked': false},
      {'value': '富山地方鉄道', 'checked': false},
    ],
    '石川県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': 'JR東海', 'checked': false},
      {'value': 'のと鉄道', 'checked': false},
      {'value': '北陸鉄道', 'checked': false},
    ],
    '福井県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': 'あいちトランジット鉄道', 'checked': false},
      {'value': '北陸鉄道', 'checked': false},
      {'value': '福井鉄道', 'checked': false},
    ],
    '山梨県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': '富士急行', 'checked': false},
      {'value': '富士山麓電気鉄道', 'checked': false},
      {'value': '山交バス', 'checked': false},
    ],
    '長野県': [
      {'value': 'JR東日本', 'checked': false},
      {'value': 'しなの鉄道', 'checked': false},
      {'value': '東日本旅客鉄道', 'checked': false},
      {'value': '長野電鉄', 'checked': false},
    ],
    '岐阜県': [
      {'value': 'JR東海', 'checked': false},
      {'value': '樽見鉄道', 'checked': false},
      {'value': 'ひだまりライン', 'checked': false},
      {'value': '飛騨中山間観光バス', 'checked': false},
    ],
    '静岡県': [
      {'value': 'JR東海', 'checked': false},
      {'value': '大井川鉄道', 'checked': false},
      {'value': '伊豆箱根鉄道', 'checked': false},
      {'value': '遠鉄バス', 'checked': false},
    ],
    '愛知県': [
      {'value': 'JR東海', 'checked': false},
      {'value': '名古屋市交通局', 'checked': false},
      {'value': '名古屋臨海高速鉄道', 'checked': false},
      {'value': '中部国際空港セントレア', 'checked': false},
    ],
    '三重県': [
      {'value': 'JR東海', 'checked': false},
      {'value': '近鉄バス', 'checked': false},
      {'value': '三重交通', 'checked': false},
      {'value': '鈴鹿自動車', 'checked': false},
    ],
    '大阪府': [
      {'value': 'JR西日本', 'checked': false},
      {'value': '大阪市営地下鉄', 'checked': false},
      {'value': '大阪モノレール', 'checked': false},
      {'value': '近畿日本鉄道', 'checked': false},
    ],
    '兵庫県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': '神戸市交通局', 'checked': false},
      {'value': '神戸新交通', 'checked': false},
      {'value': '阪神電気鉄道', 'checked': false},
    ],
    '京都府': [
      {'value': 'JR西日本', 'checked': false},
      {'value': '京都市営地下鉄', 'checked': false},
      {'value': '京福電鉄', 'checked': false},
      {'value': '叡山電鉄', 'checked': false},
    ],
    '滋賀県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': '京阪電鉄', 'checked': false},
      {'value': '近江鉄道', 'checked': false},
      {'value': '長浜浜大津観光バス', 'checked': false},
    ],
    '奈良県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': '近鉄バス', 'checked': false},
      {'value': '奈良交通', 'checked': false},
      {'value': '南都バス', 'checked': false},
    ],
    '和歌山県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': '和歌山電鐵', 'checked': false},
      {'value': '南海バス', 'checked': false},
      {'value': '和歌山バス', 'checked': false},
    ],
    '鳥取県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': '因美線', 'checked': false},
      {'value': '姫新線', 'checked': false},
      {'value': '鳥取自動車', 'checked': false},
    ],
    '島根県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': '大社線', 'checked': false},
      {'value': '宇部線', 'checked': false},
      {'value': '一畑電車', 'checked': false},
    ],
    '岡山県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': 'JR四国', 'checked': false},
      {'value': 'JR西日本', 'checked': false},
      {'value': '岡電バス', 'checked': false},
    ],
    '広島県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': 'JR四国', 'checked': false},
      {'value': 'JR西日本', 'checked': false},
      {'value': '広電バス', 'checked': false},
    ],
    '山口県': [
      {'value': 'JR西日本', 'checked': false},
      {'value': 'JR四国', 'checked': false},
      {'value': 'JR西日本', 'checked': false},
      {'value': '山電バス', 'checked': false},
    ],
    '徳島県': [
      {'value': 'JR四国', 'checked': false},
      {'value': '徳島バス', 'checked': false},
      {'value': '阿波バス', 'checked': false},
      {'value': '南海バス', 'checked': false},
    ],
    '香川県': [
      {'value': 'JR四国', 'checked': false},
      {'value': '高松琴平電気鉄道', 'checked': false},
      {'value': '琴電バス', 'checked': false},
      {'value': '富田林鉄道', 'checked': false},
    ],
    '愛媛県': [
      {'value': 'JR四国', 'checked': false},
      {'value': '伊予鉄道', 'checked': false},
      {'value': '伊予銀行バス', 'checked': false},
      {'value': '伊予鉄バス', 'checked': false},
    ],
    '高知県': [
      {'value': 'JR四国', 'checked': false},
      {'value': '土佐くろしお鉄道', 'checked': false},
      {'value': '高知都市交通', 'checked': false},
      {'value': '南国バス', 'checked': false},
    ],
    '福岡県': [
      {'value': 'JR九州', 'checked': false},
      {'value': '西鉄バス', 'checked': false},
      {'value': '福岡市営地下鉄', 'checked': false},
      {'value': '福岡市交通局', 'checked': false},
    ],
    '佐賀県': [
      {'value': 'JR九州', 'checked': false},
      {'value': '西鉄バス', 'checked': false},
      {'value': '佐賀交通', 'checked': false},
      {'value': 'バス企画', 'checked': false},
    ],
    '長崎県': [
      {'value': 'JR九州', 'checked': false},
      {'value': '西肥バス', 'checked': false},
      {'value': '長崎県営バス', 'checked': false},
      {'value': 'シーボルトレイン', 'checked': false},
    ],
    '熊本県': [
      {'value': 'JR九州', 'checked': false},
      {'value': '熊本電気鉄道', 'checked': false},
      {'value': '熊本市交通局', 'checked': false},
      {'value': '肥薩おれんじ鉄道', 'checked': false},
    ],
    '大分県': [
      {'value': 'JR九州', 'checked': false},
      {'value': '大分バス', 'checked': false},
      {'value': '日田バス', 'checked': false},
      {'value': '大分市営バス', 'checked': false},
    ],
    '宮崎県': [
      {'value': 'JR九州', 'checked': false},
      {'value': '宮崎交通', 'checked': false},
      {'value': '宮崎都市圏交通', 'checked': false},
      {'value': '宮交シティバス', 'checked': false},
    ],
    '鹿児島県': [
      {'value': 'JR九州', 'checked': false},
      {'value': '南国交通', 'checked': false},
      {'value': '鹿児島市交通局', 'checked': false},
      {'value': '指宿枕崎線', 'checked': false},
    ],
    '沖縄県': [
      {'value': '沖縄バス', 'checked': false},
      {'value': '沖縄都市モノレール', 'checked': false},
      {'value': '沖縄市営バス', 'checked': false},
      {'value': '宮古自動車', 'checked': false},
    ],
  };

//駅のリスト
  static const Map<String, List<Map<String, dynamic>>> stationList = {
    'JR東日本': [
      {'value': '東京駅', 'checked': false},
      {'value': '新宿駅', 'checked': false},
      {'value': '渋谷駅', 'checked': false},
      {'value': '品川駅', 'checked': false},
      {'value': '上野駅', 'checked': false},
      {'value': '秋葉原駅', 'checked': false},
      {'value': '池袋駅', 'checked': false},
      {'value': '赤羽駅', 'checked': false},
      {'value': '田端駅', 'checked': false},
    ],
    '東京メトロ': [
      {'value': '東京駅', 'checked': false},
      {'value': '新宿駅', 'checked': false},
      {'value': '渋谷駅', 'checked': false},
      {'value': '池袋駅', 'checked': false},
      {'value': '秋葉原駅', 'checked': false},
      {'value': '上野駅', 'checked': false},
      {'value': '六本木駅', 'checked': false},
      {'value': '銀座駅', 'checked': false},
      {'value': '浅草駅', 'checked': false},
    ],
    '都営地下鉄': [
      {'value': '三田線', 'checked': false},
      {'value': '新宿線', 'checked': false},
      {'value': '大江戸線', 'checked': false},
      {'value': '浅草線', 'checked': false},
      {'value': '三軒茶屋駅', 'checked': false},
      {'value': '雑司が谷駅', 'checked': false},
      {'value': '新宿御苑前駅', 'checked': false},
      {'value': '池上駅', 'checked': false},
      {'value': '大門駅', 'checked': false},
    ],
    '京王電鉄': [
      {'value': '京王新宿駅', 'checked': false},
      {'value': '京王八王子駅', 'checked': false},
      {'value': '京王井の頭線', 'checked': false},
      {'value': '京王線', 'checked': false},
      {'value': '京王永山駅', 'checked': false},
      {'value': '京王稲田堤駅', 'checked': false},
      {'value': '京王相模原線', 'checked': false},
    ],
    '東急電鉄': [
      {'value': '渋谷駅', 'checked': false},
      {'value': '池上駅', 'checked': false},
      {'value': '二子玉川駅', 'checked': false},
      {'value': '東急目黒線', 'checked': false},
      {'value': '東急大井町線', 'checked': false},
      {'value': '東急多摩川線', 'checked': false},
      {'value': '東急世田谷線', 'checked': false},
    ],
    '相鉄': [
      {'value': '横浜駅', 'checked': false},
      {'value': '戸塚駅', 'checked': false},
      {'value': '小田急江ノ島線', 'checked': false},
      {'value': '相模大野駅', 'checked': false},
      {'value': '十日市場駅', 'checked': false},
      {'value': '東林間駅', 'checked': false},
      {'value': '相鉄いずみ野線', 'checked': false},
    ],
    '小田急電鉄': [
      {'value': '新宿駅', 'checked': false},
      {'value': '町田駅', 'checked': false},
      {'value': '小田急線', 'checked': false},
      {'value': '小田急多摩線', 'checked': false},
      {'value': '小田急小田原線', 'checked': false},
      {'value': '東京モノレール', 'checked': false},
      {'value': '小田急東小金井駅', 'checked': false},
    ],
    '京急電鉄': [
      {'value': '品川駅', 'checked': false},
      {'value': '横浜駅', 'checked': false},
      {'value': '京急本線', 'checked': false},
      {'value': '京急空港線', 'checked': false},
      {'value': '京急久里浜線', 'checked': false},
      {'value': '京急逗子線', 'checked': false},
      {'value': '京急大師線', 'checked': false},
    ],
    '京成電鉄': [
      {'value': '上野駅', 'checked': false},
      {'value': '京成上野駅', 'checked': false},
      {'value': '京成成田駅', 'checked': false},
      {'value': '京成押上駅', 'checked': false},
      {'value': '京成金町駅', 'checked': false},
      {'value': '京成高砂駅', 'checked': false},
      {'value': '京成臼井駅', 'checked': false},
    ],
    'つくばエクスプレス': [
      {'value': '秋葉原駅', 'checked': false},
      {'value': '新宿駅', 'checked': false},
      {'value': 'つくば駅', 'checked': false},
      {'value': 'つくばエクスプレス', 'checked': false},
    ],
    '埼玉高速鉄道': [
      {'value': '大宮駅', 'checked': false},
      {'value': '北与野駅', 'checked': false},
      {'value': '西与野駅', 'checked': false},
      {'value': '川口駅', 'checked': false},
      {'value': '浦和駅', 'checked': false},
      {'value': 'さいたま新都心駅', 'checked': false},
      {'value': '与野本町駅', 'checked': false},
    ],
    '東武鉄道': [
      {'value': '東武東上線', 'checked': false},
      {'value': '東武日光線', 'checked': false},
      {'value': '東武スカイツリーライン', 'checked': false},
      {'value': '東武伊勢崎線', 'checked': false},
      {'value': '東武大師線', 'checked': false},
      {'value': '東武アーバンパークライン', 'checked': false},
      {'value': '東武野田線', 'checked': false},
    ],
    '西武鉄道': [
      {'value': '池袋駅', 'checked': false},
      {'value': '西武池袋線', 'checked': false},
      {'value': '西武新宿線', 'checked': false},
      {'value': '西武豊島線', 'checked': false},
      {'value': '西武有楽町線', 'checked': false},
      {'value': '西武山口線', 'checked': false},
      {'value': '西武多摩湖線', 'checked': false},
    ],
    '関東鉄道': [
      {'value': '竜ヶ崎駅', 'checked': false},
      {'value': '守谷駅', 'checked': false},
      {'value': '東武日光線', 'checked': false},
      {'value': 'つくばエクスプレス', 'checked': false},
      {'value': '真岡鐵道', 'checked': false},
    ],
    '青い森鉄道': [
      {'value': '青森駅', 'checked': false},
      {'value': '青い森鉄道線', 'checked': false},
      {'value': '北ふるさと鉄道', 'checked': false},
    ],
    '南部縦貫鉄道': [
      {'value': '青森駅', 'checked': false},
      {'value': '南部縦貫線', 'checked': false},
      {'value': '黒石駅', 'checked': false},
    ],
    '岩手県交通': [
      {'value': '一ノ関駅', 'checked': false},
      {'value': '盛岡駅', 'checked': false},
      {'value': '岩手県交通', 'checked': false},
    ],
    '盛岡市営バス': [
      {'value': '盛岡駅', 'checked': false},
      {'value': '県庁前駅', 'checked': false},
      {'value': '盛岡市営バス', 'checked': false},
    ],
    '釜石線': [
      {'value': '釜石駅', 'checked': false},
      {'value': '金ケ崎駅', 'checked': false},
      {'value': '釜石線', 'checked': false},
    ],
    '秋田内陸縦貫鉄道': [
      {'value': '秋田駅', 'checked': false},
      {'value': '秋田内陸縦貫鉄道', 'checked': false},
      {'value': '東北自動車道', 'checked': false},
    ],
    '秋田市営バス': [
      {'value': '秋田駅', 'checked': false},
      {'value': 'サンライズプラザ前駅', 'checked': false},
      {'value': '秋田市営バス', 'checked': false},
    ],
    '秋田空港': [
      {'value': '秋田駅', 'checked': false},
      {'value': '秋田空港', 'checked': false},
    ],
    '山形新幹線': [
      {'value': '新庄駅', 'checked': false},
      {'value': '山形駅', 'checked': false},
      {'value': '山形新幹線', 'checked': false},
    ],
    '山形駅前線': [
      {'value': '山形駅', 'checked': false},
      {'value': '山形駅前線', 'checked': false},
    ],
    '山交バス': [
      {'value': '山形駅', 'checked': false},
      {'value': '庄内空港駅', 'checked': false},
      {'value': '山交バス', 'checked': false},
    ],
    '東北新幹線': [
      {'value': '福島駅', 'checked': false},
      {'value': '仙台駅', 'checked': false},
      {'value': '東北新幹線', 'checked': false},
    ],
    '会津鉄道': [
      {'value': '会津若松駅', 'checked': false},
      {'value': '会津鉄道', 'checked': false},
    ],
    '福島交通': [
      {'value': '会津若松駅', 'checked': false},
      {'value': '会津若松市役所前駅', 'checked': false},
      {'value': '福島交通', 'checked': false},
    ],
    '上越新幹線': [
      {'value': '新潟駅', 'checked': false},
      {'value': '上越妙高駅', 'checked': false},
      {'value': '上越新幹線', 'checked': false},
    ],
    '信越本線': [
      {'value': '新潟駅', 'checked': false},
      {'value': '長岡駅', 'checked': false},
      {'value': '信越本線', 'checked': false},
    ],
    'えちごトキめき鉄道': [
      {'value': '新潟駅', 'checked': false},
      {'value': '柏崎駅', 'checked': false},
      {'value': 'えちごトキめき鉄道', 'checked': false},
    ],
    'あいの風とやま鉄道': [
      {'value': '富山駅', 'checked': false},
      {'value': '滑川駅', 'checked': false},
      {'value': 'あいの風とやま鉄道', 'checked': false},
    ],
    '富山地方鉄道': [
      {'value': '富山駅', 'checked': false},
      {'value': '富山地方鉄道', 'checked': false},
    ],
    'のと鉄道': [
      {'value': '七尾駅', 'checked': false},
      {'value': 'のと鉄道', 'checked': false},
    ],
    '北陸鉄道': [
      {'value': '金沢駅', 'checked': false},
      {'value': '北陸鉄道', 'checked': false},
    ],
    '福井鉄道': [
      {'value': '福井駅', 'checked': false},
      {'value': '福井鉄道', 'checked': false},
    ],
    'あいちトランジット鉄道': [
      {'value': '名古屋駅', 'checked': false},
      {'value': 'あいちトランジット鉄道', 'checked': false},
    ],
    '北陸鉄道 ': [
      {'value': '名古屋駅', 'checked': false},
      {'value': '飛騨市駅', 'checked': false},
      {'value': '北陸鉄道', 'checked': false},
    ],
    '名古屋臨海高速鉄道': [
      {'value': '名古屋臨海鉄道', 'checked': false},
      {'value': '名古屋臨海高速鉄道', 'checked': false},
    ],
    '中部国際空港セントレア': [
      {'value': '中部国際空港', 'checked': false},
      {'value': '中部国際空港セントレア', 'checked': false},
    ],
    '近鉄バス': [
      {'value': '三重駅', 'checked': false},
      {'value': '近鉄バス', 'checked': false},
    ],
    '三重交通': [
      {'value': '伊勢市駅', 'checked': false},
      {'value': '三重交通', 'checked': false},
    ],
    '鈴鹿自動車': [
      {'value': '四日市駅', 'checked': false},
      {'value': '鈴鹿市駅', 'checked': false},
      {'value': '鈴鹿自動車', 'checked': false},
    ],
    '大阪市営地下鉄': [
      {'value': '大阪駅', 'checked': false},
      {'value': '梅田駅', 'checked': false},
      {'value': '大阪市営地下鉄', 'checked': false},
    ],
    '大阪モノレール': [
      {'value': '大阪空港', 'checked': false},
      {'value': '大阪モノレール', 'checked': false},
    ],
    '近畿日本鉄道': [
      {'value': '大阪駅', 'checked': false},
      {'value': '近畿日本鉄道', 'checked': false},
    ],
    '神戸市交通局': [
      {'value': '三宮駅', 'checked': false},
      {'value': '神戸市交通局', 'checked': false},
    ],
    '神戸新交通': [
      {'value': '三宮駅', 'checked': false},
      {'value': 'ポートアイランド南駅', 'checked': false},
      {'value': '神戸新交通', 'checked': false},
    ],
    '阪神電気鉄道': [
      {'value': '梅田駅', 'checked': false},
      {'value': '阪神本線', 'checked': false},
      {'value': '阪神なんば線', 'checked': false},
      {'value': '阪神なんば線', 'checked': false},
    ],
    '京都市営地下鉄': [
      {'value': '京都駅', 'checked': false},
      {'value': '四条駅', 'checked': false},
      {'value': '京都市営地下鉄', 'checked': false},
    ],
    '京福電鉄': [
      {'value': '京都駅', 'checked': false},
      {'value': '北野白梅町駅', 'checked': false},
      {'value': '京福電鉄', 'checked': false},
    ],
    '叡山電鉄': [
      {'value': '京都駅', 'checked': false},
      {'value': '叡山電鉄', 'checked': false},
    ],
    '京阪電鉄': [
      {'value': '大阪駅', 'checked': false},
      {'value': '京阪電鉄', 'checked': false},
    ],
    '近江鉄道': [
      {'value': '長浜駅', 'checked': false},
      {'value': '近江鉄道', 'checked': false},
    ],
    '長浜浜大津観光バス': [
      {'value': '長浜駅', 'checked': false},
      {'value': '近江鉄道', 'checked': false},
    ],
    '近鉄バス ': [
      {'value': '橿原神宮駅', 'checked': false},
      {'value': '近鉄バス', 'checked': false},
    ],
    '奈良交通': [
      {'value': '近鉄奈良駅', 'checked': false},
      {'value': '近鉄奈良駅前駅', 'checked': false},
      {'value': '奈良交通', 'checked': false},
    ],
    '南都バス': [
      {'value': '近鉄奈良駅', 'checked': false},
      {'value': '近鉄奈良駅前駅', 'checked': false},
      {'value': '南都バス', 'checked': false},
    ],
    '和歌山電鐵': [
      {'value': '和歌山市駅', 'checked': false},
      {'value': '和歌山市駅', 'checked': false},
    ],
    '南海バス': [
      {'value': '和歌山市駅', 'checked': false},
      {'value': '南海バス', 'checked': false},
    ],
    '和歌山バス': [
      {'value': '和歌山市駅', 'checked': false},
      {'value': '和歌山市駅', 'checked': false},
    ],
    '因美線': [
      {'value': '米子駅', 'checked': false},
      {'value': '因美線', 'checked': false},
    ],
    '姫新線': [
      {'value': '出雲市駅', 'checked': false},
      {'value': '姫新線', 'checked': false},
    ],
    '鳥取自動車': [
      {'value': '鳥取駅', 'checked': false},
      {'value': '鳥取自動車', 'checked': false},
    ],
    '大社線': [
      {'value': '大社駅', 'checked': false},
      {'value': '大社線', 'checked': false},
    ],
    '宇部線': [
      {'value': '宇部駅', 'checked': false},
      {'value': '宇部線', 'checked': false},
    ],
    '一畑電車': [
      {'value': '松江駅', 'checked': false},
      {'value': '一畑電車', 'checked': false},
    ],
    '岡電バス': [
      {'value': '岡山駅', 'checked': false},
      {'value': '岡電バス', 'checked': false},
    ],
    '広電バス': [
      {'value': '広島駅', 'checked': false},
      {'value': '広電バス', 'checked': false},
    ],
    '山電バス': [
      {'value': '山口駅', 'checked': false},
      {'value': '山電バス', 'checked': false},
    ],
    '徳島バス': [
      {'value': '徳島駅', 'checked': false},
      {'value': '徳島バス', 'checked': false},
    ],
    '阿波バス': [
      {'value': '徳島駅', 'checked': false},
      {'value': '阿波バス', 'checked': false},
    ],
    '南海バス ': [
      {'value': '徳島駅', 'checked': false},
      {'value': '南海バス', 'checked': false},
    ],
    '高松琴平電気鉄道': [
      {'value': '高松駅', 'checked': false},
      {'value': '高松琴平電気鉄道', 'checked': false},
    ],
    '琴電バス': [
      {'value': '高松駅', 'checked': false},
      {'value': '琴電バス', 'checked': false},
    ],
    '富田林鉄道': [
      {'value': '高松駅', 'checked': false},
      {'value': '富田林鉄道', 'checked': false},
    ],
    '伊予鉄道': [
      {'value': '松山駅', 'checked': false},
      {'value': '伊予鉄道', 'checked': false},
    ],
    '伊予銀行バス': [
      {'value': '松山駅', 'checked': false},
      {'value': '伊予銀行バス', 'checked': false},
    ],
    '伊予鉄バス': [
      {'value': '松山駅', 'checked': false},
      {'value': '伊予鉄バス', 'checked': false},
    ],
    '土佐くろしお鉄道': [
      {'value': '高知駅', 'checked': false},
      {'value': '土佐くろしお鉄道', 'checked': false},
    ],
    '高知都市交通': [
      {'value': '高知駅', 'checked': false},
      {'value': '高知都市交通', 'checked': false},
    ],
    '南国バス': [
      {'value': '高知駅', 'checked': false},
      {'value': '南国バス', 'checked': false},
    ],
    '西鉄バス': [
      {'value': '福岡駅', 'checked': false},
      {'value': '西鉄バス', 'checked': false},
    ],
    '福岡市営地下鉄': [
      {'value': '天神駅', 'checked': false},
      {'value': '福岡市営地下鉄', 'checked': false},
    ],
    '福岡市交通局': [
      {'value': '天神駅', 'checked': false},
      {'value': '福岡市交通局', 'checked': false},
    ],
    '佐賀交通': [
      {'value': '佐賀駅', 'checked': false},
      {'value': '佐賀交通', 'checked': false},
    ],
    'バス企画': [
      {'value': '佐賀駅', 'checked': false},
      {'value': 'バス企画', 'checked': false},
    ],
    '西肥バス': [
      {'value': '長崎駅', 'checked': false},
      {'value': '西肥バス', 'checked': false},
    ],
    '長崎県営バス': [
      {'value': '長崎駅', 'checked': false},
      {'value': '長崎県営バス', 'checked': false},
    ],
    'シーボルトレイン': [
      {'value': '長崎駅', 'checked': false},
      {'value': 'シーボルトレイン', 'checked': false},
    ],
    '熊本電気鉄道': [
      {'value': '熊本駅', 'checked': false},
      {'value': '熊本電気鉄道', 'checked': false},
    ],
    '熊本市交通局': [
      {'value': '熊本駅', 'checked': false},
      {'value': '熊本市交通局', 'checked': false},
    ],
    '肥薩おれんじ鉄道': [
      {'value': '熊本駅', 'checked': false},
      {'value': '肥薩おれんじ鉄道', 'checked': false},
    ],
    '大分バス': [
      {'value': '大分駅', 'checked': false},
      {'value': '大分バス', 'checked': false},
    ],
    '日田バス': [
      {'value': '大分駅', 'checked': false},
      {'value': '日田バス', 'checked': false},
    ],
    '大分市営バス': [
      {'value': '大分駅', 'checked': false},
      {'value': '大分市営バス', 'checked': false},
    ],
    '宮崎交通': [
      {'value': '宮崎駅', 'checked': false},
      {'value': '宮崎交通', 'checked': false},
    ],
    '宮崎都市圏交通': [
      {'value': '宮崎駅', 'checked': false},
      {'value': '宮崎都市圏交通', 'checked': false},
    ],
    '宮交シティバス': [
      {'value': '宮崎駅', 'checked': false},
      {'value': '宮交シティバス', 'checked': false},
    ],
    '南国交通': [
      {'value': '鹿児島中央駅', 'checked': false},
      {'value': '南国交通', 'checked': false},
    ],
    '鹿児島市交通局': [
      {'value': '鹿児島中央駅', 'checked': false},
      {'value': '鹿児島市交通局', 'checked': false},
    ],
    '指宿枕崎線': [
      {'value': '鹿児島中央駅', 'checked': false},
      {'value': '指宿枕崎線', 'checked': false},
    ],
    '沖縄バス': [
      {'value': '那覇駅', 'checked': false},
      {'value': '沖縄バス', 'checked': false},
    ],
    '沖縄都市モノレール': [
      {'value': '那覇空港', 'checked': false},
      {'value': '沖縄都市モノレール', 'checked': false},
    ],
    '沖縄市営バス': [
      {'value': '沖縄バス', 'checked': false},
      {'value': '沖縄市営バス', 'checked': false},
    ],
    '宮古自動車': [
      {'value': '宮古空港', 'checked': false},
      {'value': '宮古自動車', 'checked': false},
    ],
  };
}
