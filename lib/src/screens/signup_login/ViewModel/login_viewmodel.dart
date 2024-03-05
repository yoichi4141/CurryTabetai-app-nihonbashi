import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/screens/signup_login/%20View/makeprofile_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';
  bool hidePassword = true; //
  bool isLoading = false; //
  String errorMessage = ''; //
  final FirebaseAuth _auth = FirebaseAuth.instance;

//パスワード可視性の部分
  void togglePasswordVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    errorMessage = '';
    notifyListeners();
    print('ログインの為に入力されたメールアドレス: $email');
  }

  void setPassword(String value) {
    password = value;
    errorMessage = '';
    notifyListeners();
    print('ログインの為に入力されたパスワード: $password');
  }

//loginする形に変更する
  Future<void> login(BuildContext context) async {
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

// Firebaseログインのメソッド
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      isLoading = false;
      errorMessage = '';
      print('ログイン成功： ${userCredential.user!.uid}');

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
