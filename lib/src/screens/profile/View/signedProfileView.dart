import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/screens/profile/ViewModel/profileViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/signup_login/%20View/makeprofile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//ログイン後のプロフィール画面です
class SignedProfileView extends StatefulWidget {
  const SignedProfileView({Key? key}) : super(key: key);

  @override
  _SignedProfileViewState createState() => _SignedProfileViewState();
}

class _SignedProfileViewState extends State<SignedProfileView> {
  late ProfileViewModel profileViewModel;

  @override
  void initState() {
    profileViewModel = ProfileViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error:$snapshot.error}');
          }

          //Firestoreからデータを取得してリストに変換
          List<DocumentSnapshot> users = snapshot.data!.docs;
          //ユーザーリストが空でないことを確認
          if (users.isEmpty) {
            return Text('No user found');
          }
          Map<String, dynamic> userData =
              users[0].data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // プロフィール画像
                  CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                          NetworkImage(userData['profileImage'] ?? '')),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      userData['displayName']?.isNotEmpty ?? false
                          ? userData['displayName']!
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
                        userData['introduction']?.isNotEmpty ?? false
                            ? userData['introduction']!
                            : '自己紹介してみてね〜',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),

                  // タイトル: 好きなカリー
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

                  // 好きなカリー
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userData['favoriteCurry']?.isNotEmpty ?? false
                            ? userData['favoriteCurry']
                            : '好きなカリーありますか〜',
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
                                    userId:
                                        profileViewModel.userModel!.userId)),
                          );
                        } else {
                          // エラーハンドリングやデフォルト値の設定などを行う
                          print('profileViewModel.user is null');
                        }
                      },
                      child: const Text('プロフィールを編集する'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text('ログアウト'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
