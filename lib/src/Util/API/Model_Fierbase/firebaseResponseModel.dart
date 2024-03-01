import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebaseResponseModel.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String email,
    required String displayName,
    required String profileImage,
    required String introduction,
    required String favoriteCurry,
  }) = _UserModel;

//Firebaseで取得したデータを使用してUserインスタンスを作成してる
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic>? data = doc.data();
    return UserModel(
      userId: doc.id,
      email: data?['email'] ?? '',
      displayName: data?['displayName'] ?? '',
      profileImage: data?['profileImage'] ?? '',
      introduction: data?['introduction'] ?? '',
      favoriteCurry: data?['favoriteCurry'] ?? '',
    );
  }
}
