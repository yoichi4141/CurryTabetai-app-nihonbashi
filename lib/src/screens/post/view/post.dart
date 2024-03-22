import 'package:currytabetaiappnihonbashi/src/screens/post/view/signd_Post_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/profile/View/guestView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  static const String routeName = '/PostScreen';

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    // ウィジェットが初期化される際にログイン状態をチェックし、リアルタイムな監視を設定する
    _checkLoginStatus();
  }

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
    bool isLogin = FirebaseAuth.instance.currentUser != null;
    return Scaffold(

        // ログイン済みだったらsignedProfileView、してなかったらguestView
        body: isLogin ? const SigndPostView() : const guestView());
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
      color: const Color.fromARGB(0, 0, 0, 0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    ),
  );
}
