// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebaseResponseModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserModel {
  String get userId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;
  String get introduction => throw _privateConstructorUsedError;
  String get favoriteCurry => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String userId,
      String email,
      String displayName,
      String profileImage,
      String introduction,
      String favoriteCurry});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? displayName = null,
    Object? profileImage = null,
    Object? introduction = null,
    Object? favoriteCurry = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      introduction: null == introduction
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String,
      favoriteCurry: null == favoriteCurry
          ? _value.favoriteCurry
          : favoriteCurry // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String email,
      String displayName,
      String profileImage,
      String introduction,
      String favoriteCurry});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? displayName = null,
    Object? profileImage = null,
    Object? introduction = null,
    Object? favoriteCurry = null,
  }) {
    return _then(_$UserModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      introduction: null == introduction
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String,
      favoriteCurry: null == favoriteCurry
          ? _value.favoriteCurry
          : favoriteCurry // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.userId,
      required this.email,
      required this.displayName,
      required this.profileImage,
      required this.introduction,
      required this.favoriteCurry});

  @override
  final String userId;
  @override
  final String email;
  @override
  final String displayName;
  @override
  final String profileImage;
  @override
  final String introduction;
  @override
  final String favoriteCurry;

  @override
  String toString() {
    return 'UserModel(userId: $userId, email: $email, displayName: $displayName, profileImage: $profileImage, introduction: $introduction, favoriteCurry: $favoriteCurry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.introduction, introduction) ||
                other.introduction == introduction) &&
            (identical(other.favoriteCurry, favoriteCurry) ||
                other.favoriteCurry == favoriteCurry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, email, displayName,
      profileImage, introduction, favoriteCurry);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String userId,
      required final String email,
      required final String displayName,
      required final String profileImage,
      required final String introduction,
      required final String favoriteCurry}) = _$UserModelImpl;

  @override
  String get userId;
  @override
  String get email;
  @override
  String get displayName;
  @override
  String get profileImage;
  @override
  String get introduction;
  @override
  String get favoriteCurry;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
