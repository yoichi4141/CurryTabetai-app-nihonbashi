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
        appBar: AppBar(title: const Text(''), actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _showSettingModal(context);
            },
          ),
        ]),
        // ログイン済みだったらsignedProfileView、してなかったらguestpostview
        body: isLogin ? const SignedpostsearchView() : const SignedpostsearchView());
  }

// 設定画面モーダルを出す関数
  void _showSettingModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  // TODO:　リンクは後で更新
                  _buildButtonWithWebView(context, Icons.help, 'お問い合わせ',
                      'https://example.com/music'),
                  _buildButtonWithWebView(context, Icons.safety_check,
                      'プライバシーポリシー', 'https://example.com/photos'),
                  _buildButtonWithWebView(context, Icons.how_to_reg, 'ご利用方法',
                      'https://example.com/video'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonWithWebView(
      BuildContext context, IconData icon, String title, String url) {
    return GestureDetector(
      onTap: () {
        // TODO: WebViewを開く処理
        // https://pub.dev/packages/webview_flutter
        print('Open WebView for $title: $url');
      },
      child: Container(
        color: Colors.transparent,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }

  signedpostView() {}
}
