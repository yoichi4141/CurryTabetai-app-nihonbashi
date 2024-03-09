import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:currytabetaiappnihonbashi/src/Util/API/Model/hotpepperApiResponse.dart';

class PostViewModel with ChangeNotifier {
  List<NearShop> nearShopList = []; // 近くのショップリスト
  List<SearchedShop> searchedShopList = []; // 検索されたショップリスト

  Future<void> searchShops(String searchText) async {
    try {
      // HotpepperAPIからデータを取得する処理
      HotpepperApiResponse apiResponse =
          await _searchHotpepperData(keyword: searchText);

      // 検索されたショップリストを更新
      searchedShopList = apiResponse.results.shop
          .map((shop) => SearchedShop.fromJson(shop.toJson()))
          .toList();

      print('検索されたショップリスト: $searchedShopList');
      notifyListeners();
    } catch (e) {
      print('Failed to search shops: $e');
    }
  }

  Future<void> fetchNearShops() async {
    try {
      // HotpepperAPIからデータを取得する処理
      HotpepperApiResponse apiResponse = await _fetchHotpepperData();

      nearShopList = apiResponse.results.shop
          .map((shop) => NearShop.fromJson(shop.toJson()))
          .toList();

      print('近くのショップリスト: $nearShopList');
      notifyListeners();
    } catch (e) {
      print('Failed to fetch near shops: $e');
    }
  }

  Future<HotpepperApiResponse> _fetchHotpepperData({String? keyword}) async {
    var dio = Dio();
    double lat = 35.68184103085021; // 仮の緯度
    double lng = 139.77912009529513; // 仮の経度

    Response response = await dio.get(
      'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/',
      queryParameters: {
        'key': '96da296d1c80e536',
        'lat': lat.toString(),
        'lng': lng.toString(),
        'keyword': keyword ?? 'カレー', // デフォルトのキーワードはカレー
        'range': '3', // 1km圏内
        'order': '4', // 距離順
        'format': 'json',
      },
    );

    return HotpepperApiResponse.fromJson(json.decode(response.data));
  }
}

Future<HotpepperApiResponse> _searchHotpepperData({String? keyword}) async {
  var dio = Dio();

  Response response = await dio.get(
    'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/',
    queryParameters: {
      'key': '96da296d1c80e536',
      'keyword': keyword ?? 'カレー', // デフォルトのキーワードはカレー
      'format': 'json',
    },
  );

  return HotpepperApiResponse.fromJson(json.decode(response.data));
}

class SearchedShop {
  String id;
  String name;
  String genre;
  String location;
  String address; // 場所(府県)

  String image;
  double lat;
  double lng;
  String time;

  SearchedShop({
    required this.id,
    required this.name,
    required this.genre,
    required this.location,
    required this.image,
    required this.address,
    required this.lat,
    required this.lng,
    required this.time,
  });

  factory SearchedShop.fromJson(Map<String, dynamic> json) {
    return SearchedShop(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      genre: json['genre'] != null ? json['genre']['name'] ?? '' : '',
      address: json['address'] ?? '',
      location: json['address'] ?? '',
      image: (json['photo'] as Map<String, dynamic>?)?['mobile']?['l'] ?? '',
      lat: json['lat'] != null ? double.parse(json['lat'].toString()) : 0.0,
      lng: json['lng'] != null ? double.parse(json['lng'].toString()) : 0.0,
      time: json['open'] ?? '',
    );
  }
  @override
  String toString() {
    return 'Name: $name, Address: $location';
  }
}

class NearShop {
  String id;
  String name; // 店舗名
  String address; // 場所(府県)
  double lat; // マップピン用　緯度
  double lng; // マップピン用　経度

  NearShop({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory NearShop.fromJson(Map<String, dynamic> json) {
    return NearShop(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
    );
  }
  @override
  String toString() {
    return 'Name: $name, Address: $address';
  }
}
