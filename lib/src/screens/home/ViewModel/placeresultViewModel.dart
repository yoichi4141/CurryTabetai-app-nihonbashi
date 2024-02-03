import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PlaceResult {
  String id;
  String name;
  String genre;
  String address;
  String photo;
  double lat;
  double lng;
  String open;

  PlaceResult(
      {required this.id,
      required this.name,
      required this.genre,
      required this.address,
      required this.photo,
      required this.lat,
      required this.lng,
      required this.open});

  factory PlaceResult.fromJson(Map<String, dynamic> placnearJson) {
    return PlaceResult(
      id: placnearJson['id'] ?? '',
      name: placnearJson['name'] ?? '',
      genre: (placnearJson['genre'] as Map<String, dynamic>)['name'] ?? '',
      address: placnearJson['address'] ?? '',
      photo:
          (placnearJson['photo'] as Map<String, dynamic>)['mobile']?['l'] ?? '',
      lat: placnearJson['lat']?.toDouble() ?? 0.0,
      lng: placnearJson['lng']?.toDouble() ?? 0.0,
      open: placnearJson['open'] ?? '',
    );
  }
}

class PlaceResultViewModel with ChangeNotifier {
  List<PlaceResult> nearbyPlaces = []; // 近くの店舗情報を保持するためのリスト

  Future<void> placeResultApi({List<double>? locationList}) async {
    var dio = Dio(); // Dio インスタンスをクラスのフィールドとして宣言

    if (locationList != null && locationList.length == 2) {
      double lat = locationList[0];
      double lng = locationList[1];

      final Response nearbySearchResponse = await dio.get(
        'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/',
        queryParameters: {
          'key': '96da296d1c80e536',
          'lat': '$lat',
          'lng': '$lng',
          'range': '3',
          'keyword': 'カレー',
          'format': 'json', // レスポンスの形式を指定する
        },
      );

      // JSON文字列をMapに変換
      Map<String, dynamic> jsonData = json.decode(nearbySearchResponse.data);

// デバッグメッセージを追加
      print('JSON Data: $jsonData');

// jsonData内の構造を確認し、必要なデータが存在するかどうかを確認
      if (jsonData.containsKey('results') && jsonData['results'] != null) {
        List<dynamic> placeResultshopList = jsonData['results']['shop'];

        // ... 以降の処理
      } else {
        print('Error: results key not found or is null in JSON data.');
      }

      //json内のshopをshopListに変換
      List<dynamic> placeResultshopList = jsonData['results']['shop'];
      // デバッグメッセージを追加
      print('Shop List: $placeResultshopList');

      // 一時変数に新しいリストを代入
      List<PlaceResult> newPlaceResultList =
          placeResultshopList.map((shopData) {
        // NearShopオブジェクトの作成
        PlaceResult placeresultnearshop = PlaceResult.fromJson(shopData);

        // id情報をプリント
        print('Shop ID: ${placeresultnearshop.id}');

        return PlaceResult.fromJson(shopData);
      }).toList();

      nearbyPlaces = newPlaceResultList;

      // デバッグメッセージを追加
      print('Nearby Places: $nearbyPlaces');

      notifyListeners();
    }
  }
}
