import 'dart:convert';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/curry_Map_Autocomplete_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map_NearshopAPI_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//検索ショップ
class SearchShop {
  String id; //店舗ID
  String name; // 店舗名

  SearchShop({
    required this.id,
    required this.name,
  });

  factory SearchShop.fromJson(Map<String, dynamic> searchJSon) {
    return SearchShop(
      id: searchJSon['id'] ?? '',
      name: searchJSon['name'] ?? '',
    );
  }
}

class SearchViewModel with ChangeNotifier {
  List<SearchShop> searchShopList = [];

  Future<void> hotpepperSearch({String? userEnteredText}) async {
    var dio = Dio();
    Response apiResponse = await dio.get(
      'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/',
      queryParameters: {
        'key': '96da296d1c80e536',
        'keyword': 'カレー$userEnteredText', // ユーザーが入力した文字列
        'middle_area': '',
        'Count': 100, //
        'format': 'json', // レスポンスの形式を指定する
        'range': ''
      },
    );

    Map<String, dynamic> jsonData = json.decode(apiResponse.data);

    List<dynamic>? shopListData = jsonData['results']['shop'];

    if (shopListData != null) {
      // shopListData内の各要素をSearchShopに変換してsearchShopListに追加
      List<SearchShop> newSearchShopList = shopListData.map((shopData) {
        // SearchShopオブジェクトの作成
        SearchShop searchShop = SearchShop.fromJson(shopData);

        // id情報をプリント

        return SearchShop.fromJson(shopData);
      }).toList();

      // オートコンプリートの候補を店舗名に設定
      searchShopList = newSearchShopList;

      notifyListeners();
    } else {
      print('shopListData is null');
    }
  }
}
