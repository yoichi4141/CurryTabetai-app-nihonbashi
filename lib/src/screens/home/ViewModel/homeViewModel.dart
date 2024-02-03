import 'package:currytabetaiappnihonbashi/src/Util/API/Model/hotpepperApiResponse.dart';
import 'package:currytabetaiappnihonbashi/src/Util/API/Service/hotpepperAPIService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  final HotpepperAPIService hotpepperAPIService = HotpepperAPIService(Dio());
  final String goodShop;
  HotpepperApiResponse response =
      HotpepperApiResponse(results: Results(shop: []));
  String errorMessage = '';
  bool isLoading = true;

  HomeViewModel(this.goodShop) {
    initialize(goodShop);
  }

  // イニシャライザでAPIを叩く
  Future<void> initialize(String goodShop) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await hotpepperAPIService.searchKeyword(goodShop);
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
}
