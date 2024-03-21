import 'dart:convert';
import 'package:currytabetaiappnihonbashi/src/Util/API/Service/shopservice.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map_NearshopAPI_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//検索ショップ
class HotpepperStoredetail {
  String id;
  String name; // 店舗名
  String genre; // カリージャンル
  String address; // 場所(府県)
  String photo;
  double lat; // マップピン用　緯度
  double lng; // マップピン用　経度
  String open; //営業時間

  HotpepperStoredetail({
    required this.id,
    required this.name,
    required this.genre,
    required this.address,
    required this.photo,
    required this.lat,
    required this.lng,
    required this.open,
  });

  factory HotpepperStoredetail.fromJson(Map<String, dynamic> storedetailJson) {
    return HotpepperStoredetail(
      id: storedetailJson['id'] ?? '',
      name: storedetailJson['name'] ?? '',
      genre: (storedetailJson['genre'] as Map<String, dynamic>)['name'] ?? '',
      address: storedetailJson['address'] ?? '',
      photo: (storedetailJson['photo'] as Map<String, dynamic>)['mobile']
              ?['l'] ??
          '',
      lat: storedetailJson['lat']?.toDouble() ?? 0.0,
      lng: storedetailJson['lng']?.toDouble() ?? 0.0,
      open: storedetailJson['open'] ?? '',
    );
  }
}

class StoreDetailsViewModel with ChangeNotifier {
  List<HotpepperStoredetail> storedetailinformation = [];

  Future<void> fetchData({String? id}) async {
    print('fetchData called');

    var dio = Dio();
    Response apiResponse = await dio.get(
      'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/',
      queryParameters: {
        'key': '96da296d1c80e536',
        'id': '$id',
        'format': 'json', // レスポンスの形式を指定する
      },
    );

    Map<String, dynamic> jsonData = json.decode(apiResponse.data);

    List<dynamic>? storedetailtData = jsonData['results']['shop'];
    if (storedetailtData != null) {
      List<HotpepperStoredetail> newstoredetailtData =
          storedetailtData.map((shopData) {
        // SearchShopオブジェクトの作成
        HotpepperStoredetail shopdetailt =
            HotpepperStoredetail.fromJson(shopData);

        // id情報をプリント

        return HotpepperStoredetail.fromJson(shopData);
      }).toList();

      storedetailinformation = newstoredetailtData;

      notifyListeners();
    }
  }
}
