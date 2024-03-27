import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GoogleStoreDetail {
  final String formattedAddress;
  final String formattedPhoneNumber;
  final String website;
  final OpeningHours openingHours; // 新しく追加

  // コンストラクタ
  GoogleStoreDetail({
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.website,
    required this.openingHours, // 新しく追加
  });
}

//営業時間
class OpeningHours {
  final bool openNow;
  final List<String> weekdayText;

  OpeningHours({
    required this.openNow,
    required this.weekdayText,
  });
}

class GoogleStoreDetailViewModel with ChangeNotifier {
  List<GoogleStoreDetail> googleStoreDetailinformation = [];

  Future<void> googlefetchData({String? name}) async {
    var dio = Dio();
    //ここで店舗名からプレイスIDを検索する
    try {
      Response googleApiResponse = await dio.get(
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
        queryParameters: {
          'query': '$name', //TODO ホットペッパーの店舗名
          'key': '', //キーを空欄にする
        },
      );

      if (googleApiResponse.statusCode == 200) {
        // レスポンスのデータを取得
        Map<String, dynamic> responseData = googleApiResponse.data;
        List<dynamic> results = responseData['results'];

        if (results.isNotEmpty) {
          // Place IDを取得
          String placeId = results[0]['place_id'];

          // Place IDを使用して店舗詳細を取得
          Response placeDetailsResponse = await dio.get(
            'https://maps.googleapis.com/maps/api/place/details/json',
            queryParameters: {
              'place_id': placeId,
              'key': '', //キーを空欄にする
              'language': 'ja',
            },
          );

          if (placeDetailsResponse.statusCode == 200) {
            Map<String, dynamic> placeDetailsData = placeDetailsResponse.data;
            Map<String, dynamic> result = placeDetailsData['result'];

            // OpeningHours情報を取得
            OpeningHours openingHours = OpeningHours(
              openNow: result['opening_hours']['open_now'] ?? false,
              weekdayText:
                  result['opening_hours']['weekday_text'].cast<String>(),
            );

            // 取得したデータを処理
            List<GoogleStoreDetail> storeDetails = [
              GoogleStoreDetail(
                formattedAddress: result['formatted_address'] != null
                    ? result['formatted_address'].toString()
                    : '',
                formattedPhoneNumber: result['formatted_phone_number'] != null
                    ? result['formatted_phone_number'].toString()
                    : '',
                website: result['website'] != null
                    ? result['website'].toString()
                    : '',
                openingHours: openingHours, // OpeningHours情報を追加
              ),
            ];

            // 取得したデータをリストにセット
            googleStoreDetailinformation = storeDetails;

            // データが変更されたことを通知
            notifyListeners();
          } else {
            print('Error: ${placeDetailsResponse.statusCode}');
          }
        } else {
          print('No results found for the store name.');
        }
      } else {
        print('Error: ${googleApiResponse.statusCode}');
      }
    } catch (error) {
      // エラー処理
      print('Error fetching data: $error');
    }
  }
}
