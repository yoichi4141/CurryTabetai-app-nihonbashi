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

class MapViewModel with ChangeNotifier {
  List<NearShop> nearShopList = []; // 初期化は空のリスト

  Future<void> hotpepperApi() async {
    var dio = Dio();
    // getCurrentLocationを使ってデバイスの位置情報を取得します
    Position position = await getCurrentLocation();

    double lat = position.latitude;
    double lng = position.longitude;
    print('Latitude: $lat');
    print('Longitude: $lng');
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
// レスポンスの内容をログに出力
    // 位置情報をプリントして確認します
    print('Current Latitude: ${position.latitude}');
    print('Current Longitude: ${position.longitude}');
    print('Response data: ${apiResponse.data}');

    // apiResponse.dataをNearShopオブジェクトに変換

    // JSON文字列をMapに変換
    Map<String, dynamic> jsonData = json.decode(apiResponse.data);
    //json内のshopをshopListに変換
    List<dynamic> shopList = jsonData['results']['shop'];

    // 一時変数に新しいリストを代入
    List<NearShop> newNearShopList = shopList.map((shopData) {
      return NearShop.fromJson(shopData);
    }).toList();

    // リストを更新する前に通知
    print('ロードされた店舗数: ${nearShopList.length} 店舗: $nearShopList');

    nearShopList = newNearShopList;
    notifyListeners();
  }

//SearchedShop
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

//検索ショップ
class SearchedShop {
  String id;
  String name; // 店舗名
  String genre; // カリージャンル
  String location; // 場所(府県)
  String image; // phoneではなくimageに変更してみました
  double lat; // マップピン用　緯度
  double lng; // マップピン用　経度
  String time; //営業時間

  SearchedShop(this.id, this.name, this.genre, this.location, this.image,
      this.lat, this.lng, this.time);
}
