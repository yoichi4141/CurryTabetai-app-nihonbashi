import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignUpViewModel extends ChangeNotifier {
  String userId = '';
  String email = '';
  String password = '';
  bool hidePassword = true; //
  bool isLoading = false; //
  String errorMessage = ''; //
  //ファイアーストア用
  String displayName = '';
  String? profileImageUrl; // 画像のパスを保持するString型の変数
  String introduction = '';
  String favoriteCurry = '';
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //users Collectionに profileをセットするメソッド
  Future<void> createUserProfile(User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(user.uid).set({
        'displayName': displayName,
        'profileImage': profileImageUrl,
        'introduction': introduction,
        'favoriteCurry': favoriteCurry,
      });
      await posts.doc(user.uid).set({
//初回登録用なのでもっと適当なのでいいかも
        'postText': null,
        'userName': null,
        'postImage': null,
        'profileImage': null,
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

class GoogleSignInService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signinWithGoogle(BuildContext context) async {
    try {
      final googleUser =
          await _googleSignIn.signIn(); // scopes: ['profile', 'email'] は不要

      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        await GoogleCreateUserProfile(FirebaseAuth.instance.currentUser!);

        // Navigator.of(context).pop(); // 前の画面へ遷移
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        print('ユーザーがログインしていません。');
      }
    } catch (e) {
      print('Googleサインインエラー:$e');
    }
  }

  Future<void> GoogleCreateUserProfile(User user) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(user.uid).set({
        'displayName': user.displayName,
        'profileImage': user.photoURL,
        // 他のユーザープロファイル情報のセットアップ
      });
      await posts.doc(user.uid).set({
//初回登録用なのでもっと適当なのでいいかも
        'postText': null,
        'userName': null,
        'postImage': null,
        'profileImage': null,
      });

      print('User profile created successfully.');
    } catch (e) {
      print('Failed to create user profile: $e');
    }
  }
}

class AppSignInService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signinWithApple(BuildContext context) async {
    try {
      final appleCredental = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      //認証情報からFirevase Authno Credentalを作成
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredental.identityToken,
        accessToken: appleCredental.authorizationCode,
      );

      // Firebaseでサインイン
      await _auth.signInWithCredential(oauthCredential);
      if (_auth.currentUser != null) {
        await createAppleUserProfile(_auth.currentUser!);

        // Navigator.of(context).pop(); // 前の画面へ遷移
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        print('ユーザーがログインしていません。');
      }
    } catch (e) {
      print('Appleサインインエラー:$e');
    }
  }

  Future<void> createAppleUserProfile(User user) async {
    try {
      await users.doc(user.uid).set({
        'displayName': user.displayName ?? 'AppleDefaultUser',
        'profileImage': user.photoURL ?? '',
      });

      print('User profile created successfully.');
    } catch (e) {
      print('Failed to create user profile: $e');
    }
  }
}
