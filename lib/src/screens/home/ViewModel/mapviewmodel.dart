import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

//nearShopListとSearchedShopをホットペッパーAPIに変更

//近くのショップ　マップリストのところでも使う
class NearShop {
  String id;
  String name; // 店舗名
  String genre; // カリージャンル
  String address; // 場所(府県)
  String photo;
  double lat; // マップピン用　緯度
  double lng; // マップピン用　経度
  String open; //営業時間

  NearShop(
      {required this.id,
      required this.name,
      required this.genre,
      required this.address,
      required this.photo,
      required this.lat,
      required this.lng,
      required this.open});

  factory NearShop.fromJson(Map<String, dynamic> nearJson) {
    return NearShop(
      id: nearJson['id'] ?? '',
      name: nearJson['name'] ?? '',
      genre: (nearJson['genre'] as Map<String, dynamic>)['name'] ?? '',
      address: nearJson['address'] ?? '',
      photo: (nearJson['photo'] as Map<String, dynamic>)['mobile']?['l'] ?? '',
      lat: nearJson['lat']?.toDouble() ?? 0.0,
      lng: nearJson['lng']?.toDouble() ?? 0.0,
      open: nearJson['open'] ?? '',
    );
  }
}

Future<Position> getCurrentLocation() async {
  // 許可の確認は行わずに、直接位置情報を取得します
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return position;
}

//店名サーチAPI
class MapViewModel with ChangeNotifier {
  List<NearShop> nearShopList = []; // 初期化は空のリスト

  Future<void> hotpepperApi() async {
    var dio = Dio();

    // getCurrentLocationを使ってデバイスの位置情報を取得します
    Position position = await getCurrentLocation();

    double lat = position.latitude;
    double lng = position.longitude;
    // グルメサーチAPIのリクエスト
    Response apiResponse = await dio.get(
      'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/',
      queryParameters: {
        'key': '96da296d1c80e536',
        'lat': lat.toString(), //一旦カリーサーチマップの仮の地点に合わせている（Vashoの場所）
        'lng': lng.toString(), //一旦カリーサーチマップの仮の地点に合わせている（Vashoの場所）
        'keyword': 'カレー',
        'range': '3', //1Km圏内
        'order': '4', //距離順
        'format': 'json', // レスポンスの形式を指定する
      },
    );
    // apiResponse.dataをNearShopオブジェクトに変換

    // JSON文字列をMapに変換
    Map<String, dynamic> jsonData = json.decode(apiResponse.data);
    //json内のshopをshopListに変換
    List<dynamic> shopList = jsonData['results']['shop'];

    // 一時変数に新しいリストを代入
    List<NearShop> newNearShopList = shopList.map((shopData) {
      // NearShopオブジェクトの作成
      NearShop nearShop = NearShop.fromJson(shopData);

      // id情報をプリント
      print('Shop ID: ${nearShop.id}');

      return NearShop.fromJson(shopData);
    }).toList();

    nearShopList = newNearShopList;
    notifyListeners();
  }
}
