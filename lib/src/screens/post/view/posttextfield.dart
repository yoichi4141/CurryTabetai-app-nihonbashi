import 'package:flutter/material.dart';

class Posttextfield extends StatefulWidget {
  const Posttextfield({Key? key}) : super(key: key);

  @override
  State<Posttextfield> createState() => _Posttextfield();
}

class _Posttextfield extends State<Posttextfield> {
  final TextEditingController _textEditingController = TextEditingController();
  final int maxCharacters = 500; // 最大文字数

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カリーログ投稿🍛'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
      body: Column(
        children: [
          SizedBox(height: 8.0),
          //リストから引き継いでくる形にする
          Text(
            "Vashon/curry&grill",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Container(
                width: 120, // 幅を調整
                height: 40, // 高さを調整
                child: TextButton(
                  onPressed: () {
                    // ボタンがタップされた時の処理
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 角丸を設定
                    ),
                  ),
                  child: Text(
                    '2023/12/10',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                width: 120, // 幅を調整
                height: 40, // 高さを調整
                child: TextButton(
                  onPressed: () {
                    // ボタンがタップされた時の処理
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 角丸を設定
                    ),
                  ),
                  child: Text(
                    '公開or非公開',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText:
                      '今日食べたカリーの味についてや、お店の雰囲気など、カリーの口コミ・感想を書いてみよう。空の状態で投稿すると「チェックイン」表示になります。',
                  border: InputBorder.none,
                ),
                maxLines: 10,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
