import 'dart:convert';

import 'package:currytabetaiappnihonbashi/src/Util/API/Model/hotpepperApiResponse.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'hotpepperAPIService.g.dart';

@RestApi(
    baseUrl:
        "https://webservice.recruit.co.jp/hotpepper") // ベースURLを実際のAPIのURLに変更
abstract class HotpepperAPIService {
  factory HotpepperAPIService(Dio dio, {String baseUrl}) = _HotpepperAPIService;

  @GET("/gourmet/v1/?key=96da296d1c80e536&format=json&count=100")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<HotpepperApiResponse> searchKeyword(
    @Query("keyword") String keyword,
  );
}
