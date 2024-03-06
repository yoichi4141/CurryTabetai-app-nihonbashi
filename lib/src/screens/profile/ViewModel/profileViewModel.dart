import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/Util/API/Model_Fierbase/firebaseResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'
    as firebase_storage; //asがないと　firebase_storage.Referenceと書かなければいけなくなる

class ProfileViewModel with ChangeNotifier {
  UserModel? userModel;
  String displayName = '';
  String? profileImageUrl; // 画像のパスを保持するString型の変数
  String introduction = '';
  String favoriteCurry = '';
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileViewModel() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // ここでユーザーIDを指定する必要があります

    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userData = snapshot.data();
    if (userData != null) {
      userModel = UserModel(
        userId: snapshot.id,
        email: userData['email'] ?? '',
        displayName: userData['displayName'] ?? '',
        profileImage: userData['profileImage'] ?? '',
        introduction: userData['introduction'] ?? '',
        favoriteCurry: userData['favoriteCurry'] ?? '',
      );
      notifyListeners();
    }
  }

//ファイアーストアのドキュメントの内容を更新するメソッド
  Future<void> updateProfile() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final String userId = user.uid;
      await users.doc(userId).update({
        'displayName': displayName,
        'profileImage': profileImageUrl,
        'introduction': introduction,
        'favoriteCurry': favoriteCurry,
      });
      updateUserData();
      print("プロフィール登録が完了");
    }
  }

// flutter側パラメーターのアップデート
  Future<void> updateUserData() async {
    // ここでユーザーIDを指定する必要があります

    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userData = snapshot.data();
    if (userData != null) {
      userModel = UserModel(
        userId: snapshot.id,
        email: userData['email'] ?? '',
        displayName: userData['displayName'] ?? '',
        profileImage: userData['profileImage'] ?? '',
        introduction: userData['introduction'] ?? '',
        favoriteCurry: userData['favoriteCurry'] ?? '',
      );
      notifyListeners();
      print('ユーザーパラメーターがアップデートされました');
      print(userModel);
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      String imagePath = pickedImage.path; // 画像のパスをセット
      String? userId = userModel?.userId;

      String imageUrl = await uploadImageToFirebaseStorage(userId!, imagePath);
      await saveImageUrlToFirestore(userId, imageUrl);
      //ここで最終的なimageUrlをパラメータprofileImageUrlに代入
      profileImageUrl = imageUrl;

      print('画像が選択されました');
      print('選択した画像のpath$imagePath]');
    } else {
      profileImageUrl = 'assets/images/india19-37359.jpg'; // デフォルトのイメージのパスをセット
      print('画像が選択されませんでした');
    }
  }

//ファイアーストレージに画像パスを保存する
  Future<String> uploadImageToFirebaseStorage(
      String userId, String imagePath) async {
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance
            .ref()
            //imagesファイルの中から特定のuserIdを持つprofileを参照している
            .child('images/$userId/profile.jpg');
    final file = File(imagePath);
    //putFileメソッドでファイルをcloud storageにアップロードしている

    await storageRef.putFile(file);

    String imageUrl = await storageRef.getDownloadURL();
    print('パス$imageUrl');

    return imageUrl;
  }

  Future<void> saveImageUrlToFirestore(String userId, String imageUrl) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'profileImage': imageUrl,
    }, SetOptions(merge: true));
  }

  void updateDisplayName(String value) {
    displayName = value;
    notifyListeners();
  }

  void updateIntroduction(String value) {
    introduction = value;
    notifyListeners();
  }

  void updateFavoriteCurry(String value) {
    favoriteCurry = value;
    notifyListeners();
  }
}
