import 'package:flutter/material.dart';

//検索バー用に何も入れていない時のViewmodel（現在地から近いものを表示するファイアーベースから）
// class PostsearcsuggesthModel with ChangeNotifier {
//   final List<String> curryshoplist = [
//     "vashon siva",
//     "vashon nihonbasi",
//     "sinabon roppongi",
//     "vashon NY",
//     "vashon newderry",
//   ];

//   final List<String> curryshoplocation = [
//     "東京都港区",
//     "東京都中央区",
//     "東京都港区",
//     "アメリカ合衆国",
//     "インドマサラカレーアイランド",
//   ];
// }

// //検索バーに何か入れた時のViewmodel(テキストからキーワードを含むものを抽出)

// class PostsearcsuggesthkeywordModel with ChangeNotifier {
//   final List<String> curryshoplistkeyword = [];
//   final List<String> curryshoplocationkeyword = [];
// }

class PostViewModel with ChangeNotifier {
  final List<NearShop> nearShopList = [
    NearShop(
      '1',
      'クマールカリーショップ',
      'インドカレー',
      '東京都港区',
      'https://tblg.k-img.com/restaurant/images/Rvw/82967/caa92ab14e1f56951a6a63b89b6e9cee.jpg',
      35.68226804974551, // 緯度
      139.77888406089832, // 経度
      '5:00~4:00',
    ),
    NearShop(
      '2',
      'クマールカリーショップ',
      'インドカレー',
      '東京都港区',
      'https://tblg.k-img.com/restaurant/images/Rvw/82967/caa92ab14e1f56951a6a63b89b6e9cee.jpg',
      35.68158673934282, // 緯度
      139.77850384412486, // 経度
      '5:00~4:00',
    ),
    NearShop(
      '3',
      'クマールカリーショップ',
      'インドカレー',
      '東京都港区',
      'https://tblg.k-img.com/restaurant/images/Rvw/82967/caa92ab14e1f56951a6a63b89b6e9cee.jpg',
      35.681875889621196, // 緯度
      139.77935612969193, // 経度
      '5:00~4:00',
    ),
  ];

  final List<SearchedShop> searchedShopList = [
    SearchedShop(
      '1',
      'クマールカリーショップ',
      'インドカレー',
      '東京都港区',
      'https://tblg.k-img.com/restaurant/images/Rvw/82967/caa92ab14e1f56951a6a63b89b6e9cee.jpg',
      35.68226804974551, // 緯度
      139.77888406089832, // 経度
      '5:00~4:00',
    ),
    SearchedShop(
      '2',
      'クマールカリーショップ',
      'インドカレー',
      '東京都港区',
      'https://tblg.k-img.com/restaurant/images/Rvw/82967/caa92ab14e1f56951a6a63b89b6e9cee.jpg',
      35.68139658018505, // 緯度
      139.7774678545175, // 経度
      '5:00~4:00',
    ),
    SearchedShop(
      '3',
      'クマールカリーショップ',
      'インドカレー',
      '東京都港区',
      'https://tblg.k-img.com/restaurant/images/Rvw/82967/caa92ab14e1f56951a6a63b89b6e9cee.jpg',
      35.68211990059177, // 緯度
      139.77825105956146, // 経度
      '5:00~4:00',
    ),
  ];
}

//近くのショップ　マップリストのところでも使う
class NearShop {
  String uid;
  String name; // 店舗名
  String genre; // カリージャンル
  String location; // 場所(府県)
  String image; // phoneではなくimageに変更してみました
  double lat; // マップピン用　緯度
  double lng; // マップピン用　経度
  String time; //営業時間

  NearShop(this.uid, this.name, this.genre, this.location, this.image, this.lat,
      this.lng, this.time);

  static elementAt(int index) {}
}

//検索ショップ
class SearchedShop {
  String uid;
  String name; // 店舗名
  String genre; // カリージャンル
  String location; // 場所(府県)
  String image; // phoneではなくimageに変更してみました
  double lat; // マップピン用　緯度
  double lng; // マップピン用　経度
  String time; //営業時間

  SearchedShop(this.uid, this.name, this.genre, this.location, this.image,
      this.lat, this.lng, this.time);
}
