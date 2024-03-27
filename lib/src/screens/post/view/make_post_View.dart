import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_Home_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/make_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MakePostView extends StatefulWidget {
  final Map<String, dynamic> data;
  const MakePostView({Key? key, required this.data}) : super(key: key);

  @override
  State<MakePostView> createState() => _Posttextfield();
}

class _Posttextfield extends State<MakePostView> {
  final TextEditingController _textEditingController = TextEditingController();
  final int maxCharacters = 500; // 最大文字数
  late DateTime selectedDate = DateTime.now(); // 選択された日付を保持する変数
  late MakePostViewModel makePostViewModel;

  @override
  Widget build(BuildContext context) {
    final makePostViewModel = Provider.of<MakePostViewModel>(context);
    String buttonText =
        '選択した日付: ${selectedDate.year}/${selectedDate.month}/${selectedDate.day}';
    if (selectedDate == DateTime.now()) {
      final DateFormat formatter = DateFormat('yyyy/MM/dd');
      buttonText = 'Today: ${formatter.format(selectedDate)}';
    } else {
      buttonText =
          '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'カリーログ投稿',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () async {
                //投稿が成功したか確認
                bool success = await makePostViewModel.createPost(
                  _textEditingController.text,
                  widget.data['id'],
                  widget.data['name'],
                );

                if (success) {
                  _textEditingController.clear();
                  int index = makePostViewModel.images.length - 1;
                  makePostViewModel.deleteImage(index);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoredetailHome(
                              id: widget.data['id'],
                              name: widget.data['name'],
                            ),
                        settings: RouteSettings(arguments: 1)),
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // ボタンの背景色を緑に設定
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0), // パディングを追加
              ),
              child: const Text(
                '投稿する',
                style: TextStyle(color: Colors.white), // テキストの色を白に設定
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 20, bottom: 10, left: 20),
              child: Text(
                widget.data['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, right: 20, bottom: 0, left: 20),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () async {
                        await makePostViewModel.selectDate(context);
                        //TODOここからどこに遷移するか考える
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        ' ${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.0, color: Colors.white),
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, right: 20, bottom: 0, left: 20),
                child: TextField(
                  controller: _textEditingController,
                  maxLength: maxCharacters,
                  decoration: const InputDecoration(
                    hintText:
                        '今日食べたカリーの味についてや、お店の雰囲気など、カリーの口コミ・感想を書いてみてくださいお願いします,お願いします',
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, right: 20, bottom: 0, left: 20),
              child: SizedBox(
                height: 120, // 横スクロールリストの高さを指定
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // 横方向のスクロールリストを作成
                  itemCount: makePostViewModel.images.length +
                      1, // +1は新しい写真を追加するためのダミーアイテム
                  itemBuilder: (BuildContext context, int index) {
                    if (index == makePostViewModel.images.length) {
                      // 最後のダミーアイテム
                      return GestureDetector(
                        onTap: () {
                          makePostViewModel.pickImage();
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          margin:
                              const EdgeInsets.only(right: 10), // アイテム間の間隔を設定
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 0.2),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 40,
                              color: Colors.grey, // アイコンの色を灰色に設定
                            ),
                          ),
                        ),
                      );
                    } else {
                      // 既存の写真を表示するアイテム
                      return GestureDetector(
                        child: Container(
                          width: 120,
                          height: 120,
                          margin:
                              const EdgeInsets.only(right: 10), // アイテム間の間隔を設定
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 0.2),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  makePostViewModel.images[index],
                                  width: 120, // 画像の幅を設定
                                  height: 120, // 画像の高さを設定

                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 29, 29, 29),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        0), // IconButton のデフォルトのパディングを削除
                                    child: IconButton(
                                      icon: Icon(Icons.close),
                                      color: Colors.white,
                                      onPressed: () {
                                        makePostViewModel.deleteImage(index);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
