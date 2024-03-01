import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/screens/profile/ViewModel/profileViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/profile/profile.dart';
import 'package:currytabetaiappnihonbashi/src/screens/signup_login/ViewModel/makeprofile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Makeprofile extends StatefulWidget {
  const Makeprofile({
    Key? key,
    required String userId,
  }) : super(key: key);

  @override
  State<Makeprofile> createState() => _MakeprofileState();
}

class _MakeprofileState extends State<Makeprofile> {
  late final MakeprofileViewmodel viewmodel;
  late final ProfileViewModel profileViewModel;

  // initStateメソッド内でMakeprofileViewmodelのインスタンスを作成する
  @override
  void initState() {
    super.initState();
    viewmodel = MakeprofileViewmodel();
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
                const CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                      'https://rotti-kanazawa.com/wp-content/uploads/2022/05/rotti_chef.png'),
                ),
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
                  onPressed: () {
                    viewmodel.updateProfile().then((_) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      // 新しいProfileViewModelインスタンスを提供して再構築をトリガーする
                      Provider.of<ProfileViewModel>(context, listen: true);
                    }).catchError((error) {
                      setState(() {
                        infoText = "登録NG:${error.toString()}";
                      });
                    });
                  },
                  child: const Text("プロフィール登録する"),
                ),
                const SizedBox(height: 8),
                Text(infoText)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
