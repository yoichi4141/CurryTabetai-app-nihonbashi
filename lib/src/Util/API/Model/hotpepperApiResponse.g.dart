// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotpepperApiResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HotpepperApiResponseImpl _$$HotpepperApiResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$HotpepperApiResponseImpl(
      results: Results.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HotpepperApiResponseImplToJson(
        _$HotpepperApiResponseImpl instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

_$ResultsImpl _$$ResultsImplFromJson(Map<String, dynamic> json) =>
    _$ResultsImpl(
      shop: (json['shop'] as List<dynamic>)
          .map((e) => Shop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ResultsImplToJson(_$ResultsImpl instance) =>
    <String, dynamic>{
      'shop': instance.shop.map((e) => e.toJson()).toList(),
    };

_$ShopImpl _$$ShopImplFromJson(Map<String, dynamic> json) => _$ShopImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      genre: Genre.fromJson(json['genre'] as Map<String, dynamic>),
      access: json['access'] as String,
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
      budget: Budget.fromJson(json['budget'] as Map<String, dynamic>),
      open: json['open'] as String,
      close: json['close'] as String,
      photo: json['photo'] == null
          ? null
          : Photo.fromJson(json['photo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ShopImplToJson(_$ShopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'genre': instance.genre.toJson(),
      'access': instance.access,
      'urls': instance.urls.toJson(),
      'budget': instance.budget.toJson(),
      'open': instance.open,
      'close': instance.close,
      'photo': instance.photo?.toJson(),
    };

_$BudgetImpl _$$BudgetImplFromJson(Map<String, dynamic> json) => _$BudgetImpl(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$BudgetImplToJson(_$BudgetImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

_$GenreImpl _$$GenreImplFromJson(Map<String, dynamic> json) => _$GenreImpl(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$GenreImplToJson(_$GenreImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

_$UrlsImpl _$$UrlsImplFromJson(Map<String, dynamic> json) => _$UrlsImpl(
      pc: json['pc'] as String,
    );

Map<String, dynamic> _$$UrlsImplToJson(_$UrlsImpl instance) =>
    <String, dynamic>{
      'pc': instance.pc,
    };

_$PhotoImpl _$$PhotoImplFromJson(Map<String, dynamic> json) => _$PhotoImpl(
      pc: Pc.fromJson(json['pc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PhotoImplToJson(_$PhotoImpl instance) =>
    <String, dynamic>{
      'pc': instance.pc,
    };

_$PcImpl _$$PcImplFromJson(Map<String, dynamic> json) => _$PcImpl(
      l: json['l'] as String?,
      m: json['m'] as String?,
      s: json['s'] as String?,
    );

Map<String, dynamic> _$$PcImplToJson(_$PcImpl instance) => <String, dynamic>{
      'l': instance.l,
      'm': instance.m,
      's': instance.s,
    };
