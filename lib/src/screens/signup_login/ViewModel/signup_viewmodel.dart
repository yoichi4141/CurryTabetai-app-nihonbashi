import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/screens/signup_login/%20View/makeprofile_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpViewModel extends ChangeNotifier {
  String userId = '';
  String email = '';
  String password = '';
  bool hidePassword = true; //
  bool isLoading = false; //
  String errorMessage = ''; //
  //ファイアーストア用
  String displayName = '';
  String? _selectedImagePath; // 画像のパスを保持するString型の変数
  String introduction = '';
  String favoriteCurry = '';
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //ファイアーストアにドキュメントを作成するメソッド
  Future<void> createUserProfile(User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(user.uid).set({
        'displayName': displayName,
        'profileImage': _selectedImagePath,
        'introduction': introduction,
        'favoriteCurry': favoriteCurry,
      });
      print('User profile created successfully.');
    } catch (e) {
      print('Failed to create user profile: $e');
    }
  }

//パスワード可視性の部分
  void togglePasswordVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    errorMessage = '';
    notifyListeners();
    print('新規登録入力されたメールアドレス: $email');
  }

  void setPassword(String value) {
    password = value;
    errorMessage = '';
    notifyListeners();
    print('新規登録入力されたパスワード: $password');
  }

  Future<void> signUp(BuildContext context) async {
    if (isLoading) return;
    //メールアドレスとパスワードが入力されていない時
    if (email.isEmpty || password.isEmpty) {
      errorMessage = 'メールアドレスとパスワードがないよ';
      notifyListeners();
      return;
    }
    //情報があるときローディングを発生させる
    try {
      isLoading = true;
      notifyListeners();
      //情報を登録する
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        //ファイアーベースのメソッドユーザー登録する
        email: email,
        password: password,
      );
      // 登録成功時にユーザープロファイルを作成
      await createUserProfile(userCredential.user!);
      isLoading = false;
      userId = userCredential.user!.uid;

      print('ユーザー登録成功： ${userId}');
      notifyListeners();

      // Navigator.of(context).pop(); // 前の画面へ遷移
      Navigator.popUntil(context, (route) => route.isFirst);

      //問題があればキャッチ
    } catch (e) {
      print('ユーザー登録エラー： $e');
      errorMessage = "登録に失敗しました：${e.toString()}";
      isLoading = false;
      notifyListeners();

      // 登録成功後の遷移処理
    }
  }
}
