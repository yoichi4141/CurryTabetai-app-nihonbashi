import 'package:currytabetaiappnihonbashi/src/screens/profile/ViewModel/profileViewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Makeprofile extends StatefulWidget {
  const Makeprofile({
    Key? key,
    required String userId,
  }) : super(key: key);

  @override
  State<Makeprofile> createState() => _MakeprofileState();
}

class _MakeprofileState extends State<Makeprofile> {
  late final ProfileViewModel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = ProfileViewModel();
  }

  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール登録'),
      ),
      // キーボードで隠れて、黄色エラーが出るので
      // SingleChildScrollViewで、Centerウイジットをラップする
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 75,
                  backgroundImage: viewmodel.profileImageUrl != null
                      ? (viewmodel.profileImageUrl is FileImage
                              ? NetworkImage(viewmodel
                                  .profileImageUrl!) // Firestoreから取得した画像のURLを設定
                              : const AssetImage(
                                  'assets/images/india19-37359.jpg') // デフォルトの画像を設定
                          ) as ImageProvider<Object> // asキーワードで型キャストを追加
                      : const AssetImage(
                          'assets/images/india19-37359.jpg'), // デフォルトの画像を設定
                  child: GestureDetector(
                    onTap: () {
                      // デフォルトの画像がタップされたときにpickImageメソッドを実行
                      viewmodel.pickImage();
                      print('ピックイメージを実行');
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text('アイコンを変更する',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(labelText: "ニックネーム:例 カリーボーイ"),
                  onChanged: (String value) {
                    viewmodel.updateDisplayName(value);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "ひとこと:例 カリーがないなんて考えられへんわな"),
                  onChanged: (String value) {
                    viewmodel.updateIntroduction(value);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: "好きなカリーは？:例 マトンカリー"),
                  onChanged: (String value) {
                    viewmodel.updateFavoriteCurry(value);
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await viewmodel.updateProfile();
                      Navigator.pop(context); // 通常のpopを実行して前の画面に戻る
                    } catch (error) {
                      setState(() {
                        infoText = "登録NG:${error.toString()}";
                      });
                    }
                  },
                  child: const Text("プロフィール登録する"),
                ),
                const SizedBox(height: 8),
                Text(infoText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
