// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:currytabetaiappnihonbashi/src/Util/API/Model_Fierbase/firebaseResponseModel.dart';
// import 'package:currytabetaiappnihonbashi/src/screens/signup_login/%20View/makeprofile_view.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';

// class MakeprofileViewmodel extends ChangeNotifier {
//   UserModel? userModel;
//   String displayName = '';
//   String? _selectedImagePath; // 画像のパスを保持するString型の変数
//   String introduction = '';
//   String favoriteCurry = '';
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   final FirebaseAuth _auth = FirebaseAuth.instance;

// // fetchUserDataメソッドを定義する
//   Future<void> fetchUserData() async {

//     final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

//     final snapshot =
//         await FirebaseFirestore.instance.collection('users').doc(userId).get();
//     final userData = snapshot.data();
//     if (userData != null) {
//       userModel = UserModel(
//         userId: snapshot.id,
//         email: userData['email'] ?? '',
//         displayName: userData['displayName'] ?? '',
//         profileImage: userData['profileImage'] ?? '',
//         introduction: userData['introduction'] ?? '',
//         favoriteCurry: userData['favoriteCurry'] ?? '',
//       );
//       notifyListeners();
//       print('メイクプロフィールUserModel: $userModel');
//     }
//   }

// //ファイアーストアのドキュメントの内容を更新するメソッド
//   Future<void> updateProfile() async {
//     final User? user = _auth.currentUser;

//     if (user != null) {
//       final String userId = user.uid;
//       await users.doc(userId).update({
//         'displayName': displayName,
//         'profileImage': _selectedImagePath,
//         'introduction': introduction,
//         'favoriteCurry': favoriteCurry,
//       });
//       print("プロフィール登録が完了");
//       fetchUserData();
//     }
//   }

//   // 画像を選択するメソッド
//   Future<void> pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       _selectedImagePath = pickedImage.path; // 画像のパスをセット
//     } else {
//       _selectedImagePath =
//           'assets/images/india19-37359.jpg'; // デフォルトのイメージのパスを設定
//     }
//     notifyListeners(); // 画像が選択されたことを通知
//   }

//   // 画像を取得するメソッド
//   File? getImageFile() {
//     if (_selectedImagePath != null) {
//       return File(_selectedImagePath!); // 画像のパスからFileオブジェクトを生成して返す
//     } else {
//       return null; // w画像がセットされていない場合はnullを返す
//     }
//   }

//   void updateDisplayName(String value) {
//     displayName = value;
//   }

//   void updateIntroduction(String value) {
//     introduction = value;
//   }

//   void updateFavoriteCurry(String value) {
//     favoriteCurry = value;
//   }
// }
