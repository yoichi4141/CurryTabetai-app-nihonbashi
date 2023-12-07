import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  // 本来はFirebaseから取得
  final String profileImage =
      'https://tenro-in.com/wp-content/uploads/de880ade6e8c9e4d8104d512d469333a.jpg';
  final String name = 'アバタル・シン・ポキ';
  final String introduction = 'Hello, 日本のカリー大好き!';
  final String favoriteFood = 'マトンカリー';
}
