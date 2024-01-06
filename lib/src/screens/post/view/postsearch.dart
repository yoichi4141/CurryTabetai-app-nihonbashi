import 'package:currytabetaiappnihonbashi/src/app.dart';

import 'package:currytabetaiappnihonbashi/src/screens/post/view/posttextfield.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/postviewmodel.dart';
import 'package:flutter/material.dart';

class SignedpostsearchView extends StatefulWidget {
  const SignedpostsearchView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignedpostsearchViewState createState() => _SignedpostsearchViewState();
}

class _SignedpostsearchViewState extends State<SignedpostsearchView> {
  late TextEditingController textEditingController;
  List<String> nearShopList = []; // 近くの店舗リスト
  List<String> searchedShopList = []; // 検索された店舗リスト

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    fetchNearShops(); // 近くの店舗データを取得する処理
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  // データを取得する処理
  void fetchNearShops() {
    nearShopList =
        PostViewModel().nearShopList.map((shop) => shop.name).toList();
  }

  void filterSearchedShops(String input) {
    // テキストが入力された場合のフィルタリング処理
    if (input.isEmpty) {
      setState(() {
        searchedShopList = [];
      });
    } else {
      setState(() {
        searchedShopList = PostViewModel()
            .searchedShopList
            .where(
                (shop) => shop.name.toLowerCase().contains(input.toLowerCase()))
            .map((shop) => shop.name)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カリーログ投稿🍛'),
        leading: IconButton(
          icon: const Icon(Icons.clear_outlined),
          onPressed: () {}, //TODO 戻る実装をつける
        ),
      ),
      body: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return nearShopList;
          } else {
            filterSearchedShops(textEditingValue.text);
            return searchedShopList;
          }
        },
        onSelected: (String selected) {
          // 選択された店舗の処理
        },
        fieldViewBuilder: (
          BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return TextField(
            controller: fieldTextEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: '行きたいカリーショップを入力',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: filterSearchedShops, // テキストが変更されたときにフィルタリングを行う
          );
        },
        optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options,
        ) {
          return Material(
            child: ListView(
              children: options.map((String shopName) {
                return ListTile(
                  title: Text(shopName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Posttextfield(data: shopName), // 遷移先のページを指定
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
