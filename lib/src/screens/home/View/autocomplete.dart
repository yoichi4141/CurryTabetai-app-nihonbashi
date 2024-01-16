import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/searchViewModel.dart';
import 'package:flutter/material.dart';

class AutocompleteExample extends StatefulWidget {
  const AutocompleteExample({Key? key}) : super(key: key);

  @override
  State<AutocompleteExample> createState() => _AutocompleteExampleState();
}

class _AutocompleteExampleState extends State<AutocompleteExample> {
  final SearchViewModel searchViewModel = SearchViewModel();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await searchViewModel.hotpepperSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAutocomplete(context, searchViewModel),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 16.0, // 下方向の位置を調整
              right: 16.0, // 右方向の位置を調整
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // テキストがタップされたときの処理
                    },
                    child: Text(
                      '件',
                      style: TextStyle(
                        color: Colors.black, // テキストの色を設定
                        fontSize: 14.0, // フォントサイズを設定
                        fontWeight: FontWeight.bold, // フォントウェイトを太くする
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0), // ボタンとテキストの間隔を調整

                  //テキストフィールドに入力して、
                  ElevatedButton(
                    onPressed: () {
                      // ボタンが押されたときの処理
                      print('ボタンが押されました！');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green, // ボタンの背景色
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fixedSize: Size(260.0, 40.0), // 追加: 幅と高さを指定
                    ),
                    child: Text(
                      '検索',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutocomplete(BuildContext context, SearchViewModel viewModel) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        // if (textEditingValue.text == '') {
        //   return const Iterable<String>.empty();
        // }
        if (viewModel.searchShopList.isEmpty) {
          // If empty, call hotpepperSearch to populate the options
          viewModel.hotpepperSearch(userEnteredText: '');
          return const Iterable<
              String>.empty(); // Return empty until data is loaded
        }
        //TODOここ考える

        return viewModel.searchShopList.where((SearchShop shop) {
          // SearchShop オブジェクト内で検索を行う
          return shop.name.contains(textEditingValue.text.toLowerCase());
        }).map((SearchShop shop) => shop.name);
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          onChanged: (String text) async {
            // テキストが変更されるたびにhotpepperSearchを呼び出す
            await Future.delayed(Duration(milliseconds: 500)); // 例: 0.5秒の遅延
            viewModel.hotpepperSearch(userEnteredText: text);
          },
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted(
                //TODOその地点にマップカメラを合わせて周辺のカリーショップをマーカー表示する
                );
          },
          style: TextStyle(color: Colors.black), // Set text color
          decoration: InputDecoration(
            hintText: '行きたいカリーショップを入力', // Set hint text
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5)), // Set hint text color
            border: OutlineInputBorder(
              // Add border
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 220, 220, 220)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 220, 220, 220)),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 12.0), // Adjust padding
          ),
        );
      },
      onSelected: (String selection) {
        print('$selectionを選択しました');
      },
    );
  }
}
