import 'package:currytabetaiappnihonbashi/src/app.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/home.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/view/make_post_View.dart';

import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/postviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigndPostView extends StatefulWidget {
  const SigndPostView({Key? key}) : super(key: key);

  @override
  _SigndPostViewState createState() => _SigndPostViewState();
}

class _SigndPostViewState extends State<SigndPostView> {
  late TextEditingController textEditingController;
  List<SearchedShop> filteredShops = [];

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();

    textEditingController.addListener(() {
      final text = textEditingController.text;
      final postViewModel = Provider.of<PostViewModel>(context, listen: false);

      if (text.isEmpty) {
        postViewModel.fetchNearShops();
      } else {
        postViewModel.searchShops(text).then((_) {
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context);
    final List<NearShop> nearShops = postViewModel.nearShopList;
    final List<SearchedShop> searchedShops = postViewModel.searchedShopList;
    //テキストがある場合、ない場合の分岐
    final List<dynamic> displayedShops =
        textEditingController.text.isEmpty ? nearShops : searchedShops;

    return Scaffold(
      appBar: AppBar(
        title: const Text('カリーログ投稿'),
        backgroundColor: Color.fromARGB(255, 99, 186, 102), // 背景色を緑色に設定
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true, // オートフォーカスを有効にする

              controller: textEditingController,
              decoration: InputDecoration(
                hintText: '行きたいカリーショップを入力',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0), // 上下の余白を調整

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // 丸みを帯びたフィールドに設定
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5)), // 枠線を薄くする
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedShops.length,
              itemBuilder: (BuildContext context, int index) {
                final shop = displayedShops[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(shop.name),
                      subtitle: Text(shop.address),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MakePostView(
                                    data: shop.name,
                                  )),
                        );
                      },
                    ),
                    Divider(color: Colors.grey[1000]), // 薄い灰色の線を描画
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
