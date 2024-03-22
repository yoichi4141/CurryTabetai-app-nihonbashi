import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'View/guestView.dart';
import 'View/signedProfileView.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String routeName = '/ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // ウィジェットが初期化される際にログイン状態をチェックし、リアルタイムな監視を設定する
    _checkLoginStatus();
  }

//ログイン状態の確認
  void _checkLoginStatus() {
    // FirebaseAuthenticationでログイン状態を取得
    bool isLogin = FirebaseAuth.instance.currentUser != null;
    print('現在のログイン状態: $isLogin');
    //ログイン状態をリアルタイムで監視している
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        if (user == null) {
          print('ログアウトしました');
        } else {
          print('ログインしました: ${user.uid}');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuthenticationでログイン状態を取得
    bool isLogin = FirebaseAuth.instance.currentUser != null;
    print('現在のログイン状態$isLogin');

    return Scaffold(
      appBar: AppBar(title: const Text(''), actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _showSettingModal(context);
          },
        ),
      ]),
      // ログイン済みだったらsignedProfileView、してなかったらguestView
      body: isLogin ? const SignedProfileView() : guestView(),
    );
  }
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
                _buildButtonWithWebView(
                    context, Icons.help, 'お問い合わせ', 'https://example.com/music'),
                _buildButtonWithWebView(context, Icons.safety_check,
                    'プライバシーポリシー', 'https://example.com/photos'),
                _buildButtonWithWebView(context, Icons.how_to_reg, 'ご利用方法',
                    'https://example.com/video'),
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
