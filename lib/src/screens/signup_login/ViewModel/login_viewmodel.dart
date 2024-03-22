import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<void> loginInWithGoogle(BuildContext context) async {
    try {
      _setLoading(true);
      _setErrorMessage('');

      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        _setUser(authResult.user);
        // Navigator.of(context).pop(); // 前の画面へ遷移
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        _setErrorMessage('Googleサインインがキャンセルされました');
      }
    } catch (e) {
      _setErrorMessage('Googleサインインに失敗しました: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
}
