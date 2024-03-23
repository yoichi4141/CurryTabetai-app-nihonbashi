import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/screens/profile/ViewModel/profileViewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Makeprofile extends StatefulWidget {
  const Makeprofile({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  State<Makeprofile> createState() => _MakeprofileState();
}

class _MakeprofileState extends State<Makeprofile> {
  late final ProfileViewModel viewmodel;
  late String userId;
  String infoText = "";

  String? imageUrl;
  ImageProvider<Object>? imageProvider;

  String? displayName;
  String? introduction;
  String? favoriteCurry;

  late TextEditingController displayNameController = TextEditingController();
  late TextEditingController introductionController = TextEditingController();
  late TextEditingController favoriteCurryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewmodel = ProfileViewModel();
    userId = widget.userId;
    //各テキストフィールドの初期値をファイアーベースから取得している
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          Map<String, dynamic>? userData =
              documentSnapshot.data() as Map<String, dynamic>?;
          displayName = userData?['displayName'];
          introduction = userData?['introduction'];
          favoriteCurry = userData?['favoriteCurry'];

          // テキストフィールドの初期値を設定
          displayNameController.text = displayName ?? '';
          introductionController.text = introduction ?? '';
          favoriteCurryController.text = favoriteCurry ?? '';
        });
      }
    }).catchError((error) {
      print("Error getting user data: $error");
    });
  }

  //Firestoreからユーザーデータの情報を取得し、フィールドに代入する

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール登録'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userId) // ユーザーIDに基づいてドキュメントを取得
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // ドキュメントデータを取得
            Map<String, dynamic>? userData =
                snapshot.data?.data() as Map<String, dynamic>?;

            // 画像の URL を取得し、NetworkImage を作成する
            String? imageUrl = userData?['profileImage'];
            ImageProvider<Object>? imageProvider = (imageUrl != null
                    ? NetworkImage(imageUrl) // Firestore から取得した画像の URL を設定
                    : const AssetImage('assets/images/india19-37359.jpg'))
                as ImageProvider<Object>?; // デフォルトの画像を設定

            displayName ??= userData?['displayName'];
            introduction ??= userData?['introduction'];
            favoriteCurry ??= userData?['favoriteCurry'];

            return Center(
              child: Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: imageProvider,
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
                      //ファイアーベースの値が格納されたテキストコントローラーを使用する
                      controller: displayNameController,
                      decoration: InputDecoration(
                        labelText: "ニックネーム:例 カリーボーイ",
                        hintText: displayName ?? 'カリーボーイ',
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      onChanged: (String value) {
                        viewmodel.updateDisplayName(displayNameController.text);
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: introductionController,
                      decoration: InputDecoration(
                        labelText: "ひとこと:例 カリーがないなんて考えられへんわな",
                        hintText: introduction ?? 'ひとことを入力してください', // 変更点
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      onChanged: (String value) {
                        viewmodel.updateIntroduction(value);
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: favoriteCurryController,
                      decoration: InputDecoration(
                        labelText: "好きなカリーは？:例 マトンカリー",
                        hintText: favoriteCurry ?? '好きなカリーを入力してください', // 変更点

                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      onChanged: (String value) {
                        viewmodel.updateFavoriteCurry(value);
                      },
                    ),
                    const SizedBox(height: 16),
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
            );
          },
        ),
      ),
    );
  }
}
