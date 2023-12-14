import 'package:flutter/material.dart';

//検索バー用に何も入れていない時のViewmodel（現在地から近いものを表示するファイアーベースから）
class PostsearcsuggesthModel with ChangeNotifier {
  final List<String> curryshoplist = [
    "vashon siva",
    "vashon nihonbasi",
    "sinabon roppongi",
    "vashon NY",
    "vashon newderry",
  ];

  final List<String> curryshoplocation = [
    "東京都港区",
    "東京都中央区",
    "東京都港区",
    "アメリカ合衆国",
    "インドマサラカレーアイランド",
  ];
}

//検索バーに何か入れた時のViewmodel(テキストからキーワードを含むものを抽出)

class PostsearcsuggesthkeywordModel with ChangeNotifier {
  final List<String> curryshoplistkeyword = [];
  final List<String> curryshoplocationkeyword = [];
}
