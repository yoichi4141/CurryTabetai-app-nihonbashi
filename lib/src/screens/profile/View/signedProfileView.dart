import 'package:currytabetaiappnihonbashi/src/screens/profile/ViewModel/profileViewModel.dart';
import 'package:flutter/material.dart';

class signedProfileView extends StatelessWidget {
  const signedProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ProfileViewModelインスタンス
    final profileViewModel = ProfileViewModel();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // プロフィール画像
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(profileViewModel.profileImage),
              ),

              // 名前
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  profileViewModel.name,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),

              // タイトル: 自己紹介
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '自己紹介:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // 自己紹介
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    profileViewModel.introduction,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ),

              // タイトル: 好きな食べ物の欄
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '好きなカリー:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // 好きな食べ物の欄
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    profileViewModel.favoriteFood,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.95, 32),
                  ),
                  onPressed: () {
                    // ここでプロフィールの編集ロジックを実装
                  },
                  child: const Text('プロフィールを編集する'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
