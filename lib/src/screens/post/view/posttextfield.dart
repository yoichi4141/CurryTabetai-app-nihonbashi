import 'dart:io'; //File? image;を追加した時に必要になった非Webアプリケーションのファイル、ソケット、HTTP、およびその他のI/Oサポート。
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //PlatformExceptionで必要
import 'package:intl/intl.dart'; //カレンダーのパッケージ
import 'package:image_picker/image_picker.dart';

class Posttextfield extends StatefulWidget {
  const Posttextfield({Key? key}) : super(key: key);

  @override
  State<Posttextfield> createState() => _Posttextfield();
}

class _Posttextfield extends State<Posttextfield> {
  final TextEditingController _textEditingController = TextEditingController();
  final int maxCharacters = 500; // 最大文字数
  late DateTime selectedDate = DateTime.now(); // 選択された日付を保持する変数
  File? image; //取得したImageのパスが入ってる

//カレンダーの関数(showDatePicker=カレンダー)
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Colors.green,
            ),
            // カレンダーの背景色を設定
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

// 画像をギャラリーから選ぶ関数
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // 画像がnullの場合戻る
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
//カレンダー何も選択肢なかったら今の日付を選択したら選択した日付を
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
            'カリーログ投稿🍛',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green, // ボタンの背景色を緑に設定
                  padding: EdgeInsets.symmetric(horizontal: 16.0), // パディングを追加
                ),
                child: Text(
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
              SizedBox(height: 0.0),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, right: 20, bottom: 0, left: 20),
                child: Text(
                  "Vashon/curry&grill",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 5, right: 20, bottom: 0, left: 20),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _selectDate(context);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          ' ${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.0),
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
                    decoration: InputDecoration(
                      hintText:
                          '今日食べたカリーの味についてや、お店の雰囲気など、カリーの口コミ・感想を書いてみよう。空の状態で投稿すると「チェックイン」表示になります。',
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 0, right: 20, bottom: 0, left: 20),
                child: Column(
                  children: [
                    // ... 他のウィジェット
                    SizedBox(height: 0),
                    image != null
                        ? Image.file(
                            image!,
                            width: 600, // 画像の幅を設定
                            height: 500, // 画像の高さを設定
                          )
                        : Text(""),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Divider(height: 16.0, color: Colors.white),
        persistentFooterButtons: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0), // パディングの設定

            child: Row(children: [
              IconButton(
                icon: Icon(Icons.image),
                iconSize: 40,
                onPressed: () {
                  pickImage();
                },
                visualDensity: VisualDensity.compact,
              ),
            ]),
          )
        ]);
  }
}
