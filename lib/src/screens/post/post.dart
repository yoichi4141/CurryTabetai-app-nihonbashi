import 'dart:math';
import 'package:currytabetaiappnihonbashi/src/screens/post/view/postsearch.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ログイン済みかをランダムに出し分ける
    // TODO: FirebaseAuthenticationで取得して出し分ける
    final random = Random();
    bool isLogin = random.nextBool();

    return Scaffold(

        // ログイン済みだったらsignedProfileView、してなかったらguestpostview
        body: isLogin
            ? const SignedpostsearchView()
            : const SignedpostsearchView());
  }
}
