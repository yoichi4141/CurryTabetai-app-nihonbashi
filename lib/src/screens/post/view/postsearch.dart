import 'package:currytabetaiappnihonbashi/src/screens/post/view/posttextfield.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel.dart/postviewmodel.dart';
import 'package:flutter/material.dart';

class SignedpostsearchView extends StatefulWidget {
  const SignedpostsearchView({Key? key}) : super(key: key);

  @override
  _SignedpostsearchViewState createState() => _SignedpostsearchViewState();
}

class _SignedpostsearchViewState extends State<SignedpostsearchView> {
  final postsearcsuggesthModel = PostsearcsuggesthModel(); //最初のリストよう
  final postsearcsuggesthkeywordModel =
      PostsearcsuggesthkeywordModel(); //入力してからのリスト用
//各リスト持ってくる用
  late List<String> curryshoplist;
  late List<String> curryshoplocation;
  late List<String> curryshoplistkeyword;
  late List<String> curryshoplocationkeyword;

//lateを使ってるので初期化してます
  @override
  void initState() {
    super.initState();
    curryshoplist = postsearcsuggesthModel.curryshoplist;
    curryshoplocation = postsearcsuggesthModel.curryshoplocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カリーログ投稿🍛'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: SearchBar(
              hintText: '行きたいカリーショップを入力',
              leading: Icon(Icons.search),
            ),
          ),

          //近くにあるカリーのリスト
          Expanded(
            child: ListView.separated(
              itemCount: curryshoplist.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Posttextfield(),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      curryshoplist[index],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      curryshoplocation[index],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
