import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationView {
  final double lat;
  final double lng;

  LocationView({
    required this.lat,
    required this.lng,
  });

  factory LocationView.fromJson(Map<String, dynamic> nearJson) {
    return LocationView(
      lat: nearJson['lat']?.toDouble(),
      lng: nearJson['lng']?.toDouble(),
    );
  }
}

//AutocompleteExampleの中だけで定義すればいい
class LocationViewModel with ChangeNotifier {
  List<double> locationList = [];

  Future<void> loadLocationData({String? placeName}) async {
    var dio = Dio(); // Dio インスタンスをクラスのフィールドとして宣言

    // 1つ目の API リクエスト (Place Search)
    final Response placeSearchResponse = await dio.get(
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json',
      queryParameters: {
        'input': '$placeName',
        'inputtype': 'textquery',
        'fields': 'geometry/location',
        'key': 'AIzaSyCWvcjiC_RlqLlNk9RBSiJSZH9eKDtcnr4',
      },
    );

    if (placeSearchResponse.statusCode == 200) {
      Map<String, dynamic>? placeSearchData = placeSearchResponse.data;

      if (placeSearchData != null) {
        List<dynamic> candidates = placeSearchData['candidates'];

        if (candidates.isNotEmpty) {
          if (candidates[0]['geometry'] != null &&
              candidates[0]['geometry']['location'] != null) {
            double? resultLat =
                candidates[0]['geometry']['location']['lat']?.toDouble();
            double? resultLng =
                candidates[0]['geometry']['location']['lng']?.toDouble();

            if (resultLat != null && resultLng != null) {
              this.locationList = [resultLat, resultLng];

              // locationListの値をプリント
              print('locationList: $locationList');
            }
          }
        }
      }
    }
  }
}
