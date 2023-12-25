// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hotpepperApiResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HotpepperApiResponse _$HotpepperApiResponseFromJson(Map<String, dynamic> json) {
  return _HotpepperApiResponse.fromJson(json);
}

/// @nodoc
mixin _$HotpepperApiResponse {
  Results get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HotpepperApiResponseCopyWith<HotpepperApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotpepperApiResponseCopyWith<$Res> {
  factory $HotpepperApiResponseCopyWith(HotpepperApiResponse value,
          $Res Function(HotpepperApiResponse) then) =
      _$HotpepperApiResponseCopyWithImpl<$Res, HotpepperApiResponse>;
  @useResult
  $Res call({Results results});

  $ResultsCopyWith<$Res> get results;
}

/// @nodoc
class _$HotpepperApiResponseCopyWithImpl<$Res,
        $Val extends HotpepperApiResponse>
    implements $HotpepperApiResponseCopyWith<$Res> {
  _$HotpepperApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as Results,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ResultsCopyWith<$Res> get results {
    return $ResultsCopyWith<$Res>(_value.results, (value) {
      return _then(_value.copyWith(results: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HotpepperApiResponseImplCopyWith<$Res>
    implements $HotpepperApiResponseCopyWith<$Res> {
  factory _$$HotpepperApiResponseImplCopyWith(_$HotpepperApiResponseImpl value,
          $Res Function(_$HotpepperApiResponseImpl) then) =
      __$$HotpepperApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Results results});

  @override
  $ResultsCopyWith<$Res> get results;
}

/// @nodoc
class __$$HotpepperApiResponseImplCopyWithImpl<$Res>
    extends _$HotpepperApiResponseCopyWithImpl<$Res, _$HotpepperApiResponseImpl>
    implements _$$HotpepperApiResponseImplCopyWith<$Res> {
  __$$HotpepperApiResponseImplCopyWithImpl(_$HotpepperApiResponseImpl _value,
      $Res Function(_$HotpepperApiResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_$HotpepperApiResponseImpl(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as Results,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HotpepperApiResponseImpl implements _HotpepperApiResponse {
  _$HotpepperApiResponseImpl({required this.results});

  factory _$HotpepperApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HotpepperApiResponseImplFromJson(json);

  @override
  final Results results;

  @override
  String toString() {
    return 'HotpepperApiResponse(results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotpepperApiResponseImpl &&
            (identical(other.results, results) || other.results == results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, results);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HotpepperApiResponseImplCopyWith<_$HotpepperApiResponseImpl>
      get copyWith =>
          __$$HotpepperApiResponseImplCopyWithImpl<_$HotpepperApiResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HotpepperApiResponseImplToJson(
      this,
    );
  }
}

abstract class _HotpepperApiResponse implements HotpepperApiResponse {
  factory _HotpepperApiResponse({required final Results results}) =
      _$HotpepperApiResponseImpl;

  factory _HotpepperApiResponse.fromJson(Map<String, dynamic> json) =
      _$HotpepperApiResponseImpl.fromJson;

  @override
  Results get results;
  @override
  @JsonKey(ignore: true)
  _$$HotpepperApiResponseImplCopyWith<_$HotpepperApiResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return _Results.fromJson(json);
}

/// @nodoc
mixin _$Results {
  List<Shop> get shop => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultsCopyWith<Results> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultsCopyWith<$Res> {
  factory $ResultsCopyWith(Results value, $Res Function(Results) then) =
      _$ResultsCopyWithImpl<$Res, Results>;
  @useResult
  $Res call({List<Shop> shop});
}

/// @nodoc
class _$ResultsCopyWithImpl<$Res, $Val extends Results>
    implements $ResultsCopyWith<$Res> {
  _$ResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shop = null,
  }) {
    return _then(_value.copyWith(
      shop: null == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as List<Shop>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultsImplCopyWith<$Res> implements $ResultsCopyWith<$Res> {
  factory _$$ResultsImplCopyWith(
          _$ResultsImpl value, $Res Function(_$ResultsImpl) then) =
      __$$ResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Shop> shop});
}

/// @nodoc
class __$$ResultsImplCopyWithImpl<$Res>
    extends _$ResultsCopyWithImpl<$Res, _$ResultsImpl>
    implements _$$ResultsImplCopyWith<$Res> {
  __$$ResultsImplCopyWithImpl(
      _$ResultsImpl _value, $Res Function(_$ResultsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shop = null,
  }) {
    return _then(_$ResultsImpl(
      shop: null == shop
          ? _value._shop
          : shop // ignore: cast_nullable_to_non_nullable
              as List<Shop>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ResultsImpl implements _Results {
  _$ResultsImpl({required final List<Shop> shop}) : _shop = shop;

  factory _$ResultsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResultsImplFromJson(json);

  final List<Shop> _shop;
  @override
  List<Shop> get shop {
    if (_shop is EqualUnmodifiableListView) return _shop;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shop);
  }

  @override
  String toString() {
    return 'Results(shop: $shop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultsImpl &&
            const DeepCollectionEquality().equals(other._shop, _shop));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_shop));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultsImplCopyWith<_$ResultsImpl> get copyWith =>
      __$$ResultsImplCopyWithImpl<_$ResultsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResultsImplToJson(
      this,
    );
  }
}

abstract class _Results implements Results {
  factory _Results({required final List<Shop> shop}) = _$ResultsImpl;

  factory _Results.fromJson(Map<String, dynamic> json) = _$ResultsImpl.fromJson;

  @override
  List<Shop> get shop;
  @override
  @JsonKey(ignore: true)
  _$$ResultsImplCopyWith<_$ResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return _Shop.fromJson(json);
}

/// @nodoc
mixin _$Shop {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  Genre get genre => throw _privateConstructorUsedError;
  String get access => throw _privateConstructorUsedError;
  Urls get urls => throw _privateConstructorUsedError;
  Budget get budget => throw _privateConstructorUsedError;
  String get open => throw _privateConstructorUsedError;
  String get close => throw _privateConstructorUsedError;
  Photo? get photo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShopCopyWith<Shop> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopCopyWith<$Res> {
  factory $ShopCopyWith(Shop value, $Res Function(Shop) then) =
      _$ShopCopyWithImpl<$Res, Shop>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String address,
      double lat,
      double lng,
      Genre genre,
      String access,
      Urls urls,
      Budget budget,
      String open,
      String close,
      Photo? photo});

  $GenreCopyWith<$Res> get genre;
  $UrlsCopyWith<$Res> get urls;
  $BudgetCopyWith<$Res> get budget;
  $PhotoCopyWith<$Res>? get photo;
}

/// @nodoc
class _$ShopCopyWithImpl<$Res, $Val extends Shop>
    implements $ShopCopyWith<$Res> {
  _$ShopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? address = null,
    Object? lat = null,
    Object? lng = null,
    Object? genre = null,
    Object? access = null,
    Object? urls = null,
    Object? budget = null,
    Object? open = null,
    Object? close = null,
    Object? photo = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      genre: null == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as Genre,
      access: null == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String,
      urls: null == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as Urls,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Budget,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as String,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as String,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as Photo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GenreCopyWith<$Res> get genre {
    return $GenreCopyWith<$Res>(_value.genre, (value) {
      return _then(_value.copyWith(genre: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UrlsCopyWith<$Res> get urls {
    return $UrlsCopyWith<$Res>(_value.urls, (value) {
      return _then(_value.copyWith(urls: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetCopyWith<$Res> get budget {
    return $BudgetCopyWith<$Res>(_value.budget, (value) {
      return _then(_value.copyWith(budget: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PhotoCopyWith<$Res>? get photo {
    if (_value.photo == null) {
      return null;
    }

    return $PhotoCopyWith<$Res>(_value.photo!, (value) {
      return _then(_value.copyWith(photo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShopImplCopyWith<$Res> implements $ShopCopyWith<$Res> {
  factory _$$ShopImplCopyWith(
          _$ShopImpl value, $Res Function(_$ShopImpl) then) =
      __$$ShopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String address,
      double lat,
      double lng,
      Genre genre,
      String access,
      Urls urls,
      Budget budget,
      String open,
      String close,
      Photo? photo});

  @override
  $GenreCopyWith<$Res> get genre;
  @override
  $UrlsCopyWith<$Res> get urls;
  @override
  $BudgetCopyWith<$Res> get budget;
  @override
  $PhotoCopyWith<$Res>? get photo;
}

/// @nodoc
class __$$ShopImplCopyWithImpl<$Res>
    extends _$ShopCopyWithImpl<$Res, _$ShopImpl>
    implements _$$ShopImplCopyWith<$Res> {
  __$$ShopImplCopyWithImpl(_$ShopImpl _value, $Res Function(_$ShopImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? address = null,
    Object? lat = null,
    Object? lng = null,
    Object? genre = null,
    Object? access = null,
    Object? urls = null,
    Object? budget = null,
    Object? open = null,
    Object? close = null,
    Object? photo = freezed,
  }) {
    return _then(_$ShopImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      genre: null == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as Genre,
      access: null == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String,
      urls: null == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as Urls,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Budget,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as String,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as String,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as Photo?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ShopImpl implements _Shop {
  _$ShopImpl(
      {this.id,
      required this.name,
      required this.address,
      required this.lat,
      required this.lng,
      required this.genre,
      required this.access,
      required this.urls,
      required this.budget,
      required this.open,
      required this.close,
      this.photo});

  factory _$ShopImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String address;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final Genre genre;
  @override
  final String access;
  @override
  final Urls urls;
  @override
  final Budget budget;
  @override
  final String open;
  @override
  final String close;
  @override
  final Photo? photo;

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, address: $address, lat: $lat, lng: $lng, genre: $genre, access: $access, urls: $urls, budget: $budget, open: $open, close: $close, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.access, access) || other.access == access) &&
            (identical(other.urls, urls) || other.urls == urls) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.close, close) || other.close == close) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address, lat, lng,
      genre, access, urls, budget, open, close, photo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopImplCopyWith<_$ShopImpl> get copyWith =>
      __$$ShopImplCopyWithImpl<_$ShopImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopImplToJson(
      this,
    );
  }
}

abstract class _Shop implements Shop {
  factory _Shop(
      {final String? id,
      required final String name,
      required final String address,
      required final double lat,
      required final double lng,
      required final Genre genre,
      required final String access,
      required final Urls urls,
      required final Budget budget,
      required final String open,
      required final String close,
      final Photo? photo}) = _$ShopImpl;

  factory _Shop.fromJson(Map<String, dynamic> json) = _$ShopImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get address;
  @override
  double get lat;
  @override
  double get lng;
  @override
  Genre get genre;
  @override
  String get access;
  @override
  Urls get urls;
  @override
  Budget get budget;
  @override
  String get open;
  @override
  String get close;
  @override
  Photo? get photo;
  @override
  @JsonKey(ignore: true)
  _$$ShopImplCopyWith<_$ShopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Budget _$BudgetFromJson(Map<String, dynamic> json) {
  return _Budget.fromJson(json);
}

/// @nodoc
mixin _$Budget {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BudgetCopyWith<Budget> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCopyWith<$Res> {
  factory $BudgetCopyWith(Budget value, $Res Function(Budget) then) =
      _$BudgetCopyWithImpl<$Res, Budget>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$BudgetCopyWithImpl<$Res, $Val extends Budget>
    implements $BudgetCopyWith<$Res> {
  _$BudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetImplCopyWith<$Res> implements $BudgetCopyWith<$Res> {
  factory _$$BudgetImplCopyWith(
          _$BudgetImpl value, $Res Function(_$BudgetImpl) then) =
      __$$BudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$BudgetImplCopyWithImpl<$Res>
    extends _$BudgetCopyWithImpl<$Res, _$BudgetImpl>
    implements _$$BudgetImplCopyWith<$Res> {
  __$$BudgetImplCopyWithImpl(
      _$BudgetImpl _value, $Res Function(_$BudgetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$BudgetImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetImpl implements _Budget {
  _$BudgetImpl({required this.name});

  factory _$BudgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'Budget(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      __$$BudgetImplCopyWithImpl<_$BudgetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetImplToJson(
      this,
    );
  }
}

abstract class _Budget implements Budget {
  factory _Budget({required final String name}) = _$BudgetImpl;

  factory _Budget.fromJson(Map<String, dynamic> json) = _$BudgetImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Genre _$GenreFromJson(Map<String, dynamic> json) {
  return _Genre.fromJson(json);
}

/// @nodoc
mixin _$Genre {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenreCopyWith<Genre> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenreCopyWith<$Res> {
  factory $GenreCopyWith(Genre value, $Res Function(Genre) then) =
      _$GenreCopyWithImpl<$Res, Genre>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$GenreCopyWithImpl<$Res, $Val extends Genre>
    implements $GenreCopyWith<$Res> {
  _$GenreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenreImplCopyWith<$Res> implements $GenreCopyWith<$Res> {
  factory _$$GenreImplCopyWith(
          _$GenreImpl value, $Res Function(_$GenreImpl) then) =
      __$$GenreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$GenreImplCopyWithImpl<$Res>
    extends _$GenreCopyWithImpl<$Res, _$GenreImpl>
    implements _$$GenreImplCopyWith<$Res> {
  __$$GenreImplCopyWithImpl(
      _$GenreImpl _value, $Res Function(_$GenreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$GenreImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenreImpl implements _Genre {
  _$GenreImpl({required this.name});

  factory _$GenreImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenreImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'Genre(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenreImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenreImplCopyWith<_$GenreImpl> get copyWith =>
      __$$GenreImplCopyWithImpl<_$GenreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenreImplToJson(
      this,
    );
  }
}

abstract class _Genre implements Genre {
  factory _Genre({required final String name}) = _$GenreImpl;

  factory _Genre.fromJson(Map<String, dynamic> json) = _$GenreImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$GenreImplCopyWith<_$GenreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return _Urls.fromJson(json);
}

/// @nodoc
mixin _$Urls {
  String get pc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UrlsCopyWith<Urls> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlsCopyWith<$Res> {
  factory $UrlsCopyWith(Urls value, $Res Function(Urls) then) =
      _$UrlsCopyWithImpl<$Res, Urls>;
  @useResult
  $Res call({String pc});
}

/// @nodoc
class _$UrlsCopyWithImpl<$Res, $Val extends Urls>
    implements $UrlsCopyWith<$Res> {
  _$UrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pc = null,
  }) {
    return _then(_value.copyWith(
      pc: null == pc
          ? _value.pc
          : pc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UrlsImplCopyWith<$Res> implements $UrlsCopyWith<$Res> {
  factory _$$UrlsImplCopyWith(
          _$UrlsImpl value, $Res Function(_$UrlsImpl) then) =
      __$$UrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pc});
}

/// @nodoc
class __$$UrlsImplCopyWithImpl<$Res>
    extends _$UrlsCopyWithImpl<$Res, _$UrlsImpl>
    implements _$$UrlsImplCopyWith<$Res> {
  __$$UrlsImplCopyWithImpl(_$UrlsImpl _value, $Res Function(_$UrlsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pc = null,
  }) {
    return _then(_$UrlsImpl(
      pc: null == pc
          ? _value.pc
          : pc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UrlsImpl implements _Urls {
  _$UrlsImpl({required this.pc});

  factory _$UrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UrlsImplFromJson(json);

  @override
  final String pc;

  @override
  String toString() {
    return 'Urls(pc: $pc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrlsImpl &&
            (identical(other.pc, pc) || other.pc == pc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UrlsImplCopyWith<_$UrlsImpl> get copyWith =>
      __$$UrlsImplCopyWithImpl<_$UrlsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UrlsImplToJson(
      this,
    );
  }
}

abstract class _Urls implements Urls {
  factory _Urls({required final String pc}) = _$UrlsImpl;

  factory _Urls.fromJson(Map<String, dynamic> json) = _$UrlsImpl.fromJson;

  @override
  String get pc;
  @override
  @JsonKey(ignore: true)
  _$$UrlsImplCopyWith<_$UrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return _Photo.fromJson(json);
}

/// @nodoc
mixin _$Photo {
  Pc get pc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotoCopyWith<Photo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoCopyWith<$Res> {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) then) =
      _$PhotoCopyWithImpl<$Res, Photo>;
  @useResult
  $Res call({Pc pc});

  $PcCopyWith<$Res> get pc;
}

/// @nodoc
class _$PhotoCopyWithImpl<$Res, $Val extends Photo>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pc = null,
  }) {
    return _then(_value.copyWith(
      pc: null == pc
          ? _value.pc
          : pc // ignore: cast_nullable_to_non_nullable
              as Pc,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PcCopyWith<$Res> get pc {
    return $PcCopyWith<$Res>(_value.pc, (value) {
      return _then(_value.copyWith(pc: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PhotoImplCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$$PhotoImplCopyWith(
          _$PhotoImpl value, $Res Function(_$PhotoImpl) then) =
      __$$PhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Pc pc});

  @override
  $PcCopyWith<$Res> get pc;
}

/// @nodoc
class __$$PhotoImplCopyWithImpl<$Res>
    extends _$PhotoCopyWithImpl<$Res, _$PhotoImpl>
    implements _$$PhotoImplCopyWith<$Res> {
  __$$PhotoImplCopyWithImpl(
      _$PhotoImpl _value, $Res Function(_$PhotoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pc = null,
  }) {
    return _then(_$PhotoImpl(
      pc: null == pc
          ? _value.pc
          : pc // ignore: cast_nullable_to_non_nullable
              as Pc,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhotoImpl implements _Photo {
  _$PhotoImpl({required this.pc});

  factory _$PhotoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoImplFromJson(json);

  @override
  final Pc pc;

  @override
  String toString() {
    return 'Photo(pc: $pc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoImpl &&
            (identical(other.pc, pc) || other.pc == pc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoImplCopyWith<_$PhotoImpl> get copyWith =>
      __$$PhotoImplCopyWithImpl<_$PhotoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoImplToJson(
      this,
    );
  }
}

abstract class _Photo implements Photo {
  factory _Photo({required final Pc pc}) = _$PhotoImpl;

  factory _Photo.fromJson(Map<String, dynamic> json) = _$PhotoImpl.fromJson;

  @override
  Pc get pc;
  @override
  @JsonKey(ignore: true)
  _$$PhotoImplCopyWith<_$PhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Pc _$PcFromJson(Map<String, dynamic> json) {
  return _Pc.fromJson(json);
}

/// @nodoc
mixin _$Pc {
  String? get l => throw _privateConstructorUsedError;
  String? get m => throw _privateConstructorUsedError;
  String? get s => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PcCopyWith<Pc> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PcCopyWith<$Res> {
  factory $PcCopyWith(Pc value, $Res Function(Pc) then) =
      _$PcCopyWithImpl<$Res, Pc>;
  @useResult
  $Res call({String? l, String? m, String? s});
}

/// @nodoc
class _$PcCopyWithImpl<$Res, $Val extends Pc> implements $PcCopyWith<$Res> {
  _$PcCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? l = freezed,
    Object? m = freezed,
    Object? s = freezed,
  }) {
    return _then(_value.copyWith(
      l: freezed == l
          ? _value.l
          : l // ignore: cast_nullable_to_non_nullable
              as String?,
      m: freezed == m
          ? _value.m
          : m // ignore: cast_nullable_to_non_nullable
              as String?,
      s: freezed == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PcImplCopyWith<$Res> implements $PcCopyWith<$Res> {
  factory _$$PcImplCopyWith(_$PcImpl value, $Res Function(_$PcImpl) then) =
      __$$PcImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? l, String? m, String? s});
}

/// @nodoc
class __$$PcImplCopyWithImpl<$Res> extends _$PcCopyWithImpl<$Res, _$PcImpl>
    implements _$$PcImplCopyWith<$Res> {
  __$$PcImplCopyWithImpl(_$PcImpl _value, $Res Function(_$PcImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? l = freezed,
    Object? m = freezed,
    Object? s = freezed,
  }) {
    return _then(_$PcImpl(
      l: freezed == l
          ? _value.l
          : l // ignore: cast_nullable_to_non_nullable
              as String?,
      m: freezed == m
          ? _value.m
          : m // ignore: cast_nullable_to_non_nullable
              as String?,
      s: freezed == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PcImpl implements _Pc {
  _$PcImpl({this.l, this.m, this.s});

  factory _$PcImpl.fromJson(Map<String, dynamic> json) =>
      _$$PcImplFromJson(json);

  @override
  final String? l;
  @override
  final String? m;
  @override
  final String? s;

  @override
  String toString() {
    return 'Pc(l: $l, m: $m, s: $s)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PcImpl &&
            (identical(other.l, l) || other.l == l) &&
            (identical(other.m, m) || other.m == m) &&
            (identical(other.s, s) || other.s == s));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, l, m, s);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PcImplCopyWith<_$PcImpl> get copyWith =>
      __$$PcImplCopyWithImpl<_$PcImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PcImplToJson(
      this,
    );
  }
}

abstract class _Pc implements Pc {
  factory _Pc({final String? l, final String? m, final String? s}) = _$PcImpl;

  factory _Pc.fromJson(Map<String, dynamic> json) = _$PcImpl.fromJson;

  @override
  String? get l;
  @override
  String? get m;
  @override
  String? get s;
  @override
  @JsonKey(ignore: true)
  _$$PcImplCopyWith<_$PcImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
