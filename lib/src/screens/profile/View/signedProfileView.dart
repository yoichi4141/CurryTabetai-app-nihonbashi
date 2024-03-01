import 'package:currytabetaiappnihonbashi/src/screens/profile/ViewModel/profileViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/signup_login/%20View/makeprofile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//ログイン後のプロフィール画面です
class SignedProfileView extends StatefulWidget {
  const SignedProfileView({Key? key}) : super(key: key);

  @override
  _SignedProfileViewState createState() => _SignedProfileViewState();
}

class _SignedProfileViewState extends State<SignedProfileView> {
  // プロフィール画像の更新など、必要な状態やメソッドを追加します

  @override
  Widget build(BuildContext context) {
    // ProfileViewModelインスタンスはプロバイダーで状態管理する
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: true);

    return ChangeNotifierProvider.value(
        value: profileViewModel,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // プロフィール画像
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: profileViewModel.userModel?.profileImage !=
                          null
                      ? NetworkImage(profileViewModel.userModel!.profileImage)
                      : AssetImage('assets/images/india19-37359.jpg')
                          as ImageProvider<Object>,
                ),

                // 名前
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    profileViewModel.userModel?.displayName != null
                        ? profileViewModel.userModel!.displayName
                        : '名前はまだない',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                // タイトル: 自己紹介
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '自己紹介:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // 自己紹介
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      profileViewModel.userModel?.introduction != null
                          ? profileViewModel.userModel!.introduction
                          : 'まだ設定していないでしょう',
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
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // 好きな食べ物の欄
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      profileViewModel.userModel?.favoriteCurry != null
                          ? profileViewModel.userModel!.favoriteCurry
                          : 'まだ設定してないね〜',
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
                      if (profileViewModel.userModel != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Makeprofile(
                                  userId: profileViewModel.userModel!.userId)),
                        );
                      } else {
                        // エラーハンドリングやデフォルト値の設定などを行う
                        print('profileViewModel.user is null');
                      }
                    },
                    child: const Text('プロフィールを編集する'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
