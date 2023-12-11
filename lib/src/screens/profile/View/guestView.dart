import 'package:currytabetaiappnihonbashi/src/signup_login/onboardingView.dart';
import 'package:flutter/material.dart';

class guestView extends StatelessWidget {
  const guestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'カリータベタイでしょ！？',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // タイトルと説明の間にスペースを設ける
            const Text(
              '登録しないとカリー食べれないよ、ナニやってる！',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32), // 説明とボタンの間にスペースを設ける
            ElevatedButton(
              onPressed: () {
                // 新規登録画面に遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingView()),
                );
              },
              child: Text('新規登録またはログイン'),
            ),
          ],
        ),
      ),
    );
  }
}
