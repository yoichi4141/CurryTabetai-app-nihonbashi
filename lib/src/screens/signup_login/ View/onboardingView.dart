import 'package:currytabetaiappnihonbashi/src/screens/signup_login/%20View/loginView.dart';
import 'package:currytabetaiappnihonbashi/src/screens/signup_login/%20View/signupView.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);
  static const String routeName = '/OnboardingView';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: 2, // タブの数
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: '新規登録'),
              Tab(text: 'ログイン'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SignupView(),
            loginView(),
          ],
        ),
      ),
    );
  }
}
