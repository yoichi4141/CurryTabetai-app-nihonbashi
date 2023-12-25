import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotpepperApiResponse.g.dart';
part 'hotpepperApiResponse.freezed.dart';

@freezed
class HotpepperApiResponse with _$HotpepperApiResponse {
  factory HotpepperApiResponse({
    required Results results,
  }) = _HotpepperApiResponse;

  factory HotpepperApiResponse.fromJson(Map<String, dynamic> json) =>
      _$HotpepperApiResponseFromJson(json);
}

@freezed
class Results with _$Results {
  @JsonSerializable(explicitToJson: true)
  factory Results({
    required List<Shop> shop,
  }) = _Results;

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}

@freezed
abstract class Shop with _$Shop {
  @JsonSerializable(explicitToJson: true)
  factory Shop({
    String? id,
    required String name,
    required String address,
    required double lat,
    required double lng,
    required Genre genre,
    required String access,
    required Urls urls,
    required Budget budget,
    required String open,
    required String close,
    Photo? photo,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}

@freezed
abstract class Budget with _$Budget {
  factory Budget({
    required String name,
  }) = _Budget;

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
}

@freezed
abstract class Genre with _$Genre {
  factory Genre({
    required String name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@freezed
abstract class Urls with _$Urls {
  factory Urls({
    required String pc,
  }) = _Urls;

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
}

@freezed
abstract class Photo with _$Photo {
  factory Photo({
    required Pc pc,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

@freezed
abstract class Pc with _$Pc {
  factory Pc({
    String? l,
    String? m,
    String? s,
  }) = _Pc;

  factory Pc.fromJson(Map<String, dynamic> json) => _$PcFromJson(json);
}
