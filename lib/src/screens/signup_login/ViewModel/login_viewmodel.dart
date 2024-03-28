import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

//メルアドのログインViremodel
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

// Firebaseログインのメソッドcredential
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      isLoading = false;
      errorMessage = '';
      print('ログイン成功： ${userCredential.user!.uid}');

      // メール認証が成功した後、GoogleAuthProviderを使用して追加の認証情報をリンクする

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

//GoogleのログインViewmodel
class LoginWithGooglViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  User? _user;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  User? get user => _user;

  //ローディング状態の更新
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // エラーメッセージの更新
  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // ユーザー情報の更新
  void _setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  // Googleアカウントでログイン
  Future<void> loginInWithGoogle(
      BuildContext context, String email, String password) async {
    try {
      _setLoading(true);
      _setErrorMessage('');

      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        _setUser(authResult.user);

//追加の認証情報をリンクする
//Eメール
        final emailCredential =
            EmailAuthProvider.credential(email: email, password: password);
        await authResult.user?.linkWithCredential(emailCredential);
      } else {
        _setErrorMessage('Googleサインインがキャンセルされました');
      }
    } catch (e) {
      _setErrorMessage('Googleサインインに失敗しました: ${e.toString()}');
    } finally {
      _setLoading(false);
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }
}

class LoginWithAppleViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  User? _user;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  User? get user => _user;

  //ローディング状態の更新
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // エラーメッセージの更新
  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // ユーザー情報の更新
  void _setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> loginWithinApple(BuildContext context) async {
    try {
      final appleCredental = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      //Appleの認証データをFirebaseの認証データに変換
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredental.identityToken,
        accessToken: appleCredental.authorizationCode,
      );

      //Firebaseでサインイン
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      //ユーザー情報の取得
      final user = authResult.user;
    } catch (e) {
      print(e);
    } finally {
      _setLoading(false);
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }
}
