import 'package:currytabetaiappnihonbashi/src/Util/API/Model/hotpepperApiResponse.dart';
import 'package:currytabetaiappnihonbashi/src/Util/API/Service/hotpepperAPIService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CurryTypeSearchListViewModel with ChangeNotifier {
  final HotpepperAPIService hotpepperAPIService = HotpepperAPIService(Dio());
  final String searchKeyword;
  HotpepperApiResponse response =
      HotpepperApiResponse(results: Results(shop: []));
  String errorMessage = '';
  bool isLoading = true;

  List<Shop> _saveShops = [];

  CurryTypeSearchListViewModel(this.searchKeyword) {
    initialize(searchKeyword);
  }

  // イニシャライザでAPIを叩く
  Future<void> initialize(String searchKeyword) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await hotpepperAPIService.searchKeyword(searchKeyword);
      this.response = response;
      print(response);
    } catch (e) {
      // エラーハンドリング
      errorMessage = e.toString();
      print("Error: $errorMessage");
      isLoading = false;
      notifyListeners();
    } finally {
      // データ取得が完了したらローディングを終了
      isLoading = false;
      notifyListeners();
    }
  }

  // 名前順でソートする関数
  void sortShopsByName(List<Shop> shops) {
    // 新しいリストを作成しないとエラー出る
    List<Shop> sortedShops = List.from(shops);
    sortedShops.sort((a, b) => a.name.compareTo(b.name));
    response = HotpepperApiResponse(results: Results(shop: sortedShops));
    notifyListeners();
  }

  // 予算やすい順でソートする関数
  void sortShopsByPrice(List<Shop> shops) {
    List<Shop> sortedShops = List.from(shops);
    sortedShops.sort((a, b) =>
        _extractPrice(a.budget.name).compareTo(_extractPrice(b.budget.name)));
    response = HotpepperApiResponse(results: Results(shop: sortedShops));
    notifyListeners();
  }

  // 文字列から数字だけを抽出して数値に変換
  int _extractPrice(String input) {
    RegExp regExp = RegExp(r'\d+');
    List<String> matches =
        regExp.allMatches(input).map((match) => match.group(0)!).toList();
    return int.parse(matches.isNotEmpty ? matches.first : '0');
  }

  // 検索キーワードが空の場合はフィルタリングせず、元のリストを表示
  void filterList(String searchText) {
    if (_saveShops.isEmpty) {
      _saveShops = response.results.shop;
    } else {
      response = HotpepperApiResponse(results: Results(shop: _saveShops));
    }

    if (searchText.isEmpty) {
      return;
    }

    final List<Shop> filteredShops = response.results.shop
        .where((shop) =>
            shop.name.toLowerCase().contains(searchText.toLowerCase()) ||
            shop.name.codeUnits
                .any((unit) => searchText.codeUnits.contains(unit)))
        .toList();
    response = HotpepperApiResponse(results: Results(shop: filteredShops));
    notifyListeners();
  }
}
