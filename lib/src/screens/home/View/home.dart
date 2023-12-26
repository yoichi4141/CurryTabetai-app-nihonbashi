import 'package:currytabetaiappnihonbashi/src/screens/home/View/curryTypeSearchListView.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/currysearchmap.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ボタンスタイル
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
    ).merge(
      ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
    //地図画像の下の件数　TODOデータベースから引っ張る
    var currysearchcount = 10000;
    //カリータイプから探すリスト
    List<String> currytypeimage = [
      'assets/images/indeiacurry.png',
      'assets/images/soupcurry.png',
      'assets/images/srilankacurry.png',
      'assets/images/taicurry.png',
      'assets/images/spicecurry.png',
    ];
    //カリータイプの下のテキスト
    List<String> curryTypeText = [
      'インドカレー',
      'スープカレー',
      'スリランカカレー',
      'タイカレー',
      'ネパールカレー',
    ];

    //最近オープンしたカリーショップ(仮) TODOデータベースから引っ張るようにする
    List<String> opencurryshop = [
      'assets/images/sample.png',
      'assets/images/sample.png',
      'assets/images/sample.png',
      'assets/images/sample.png',
      'assets/images/sample.png',
      'assets/images/sample.png',
    ];
    //最近オープンしたカリーショップ店舗名　TODOデータベースから引っ張るようにする
    List<String> opencurryshoptext = [
      'Vashon/curry&grillfaaaaaaaaaaaaaaaaa',
      'Vashon/curry&grill',
      'Vashon/curry&grill',
      'Vashon/curry&grill',
      'Vashon/curry&grill',
      'Vashon/curry&grill',
    ];

    //最近オープンしたカリーショップのカリージャンル　TODOデータベースから引っ張るようにする
    List<String> opencurryshopgenre = [
      'その他カリー',
      'その他カリー',
      'その他カリー',
      'その他カリー',
      'その他カリー',
      'その他カリー',
    ];

    //最近オープンしたカリーショップの所在地　TODOデータベースから引っ張るようにする
    List<String> opencurryshoplocation = [
      '東京都港区',
      '東京都港区',
      '東京都港区',
      '東京都港区',
      '東京都港区',
      '東京都港区',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child:
                  Image(image: AssetImage('assets/images/india19-37359.jpg')),
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: SearchBar(
                hintText: '行きたいカリ〜を検索',
                leading: Icon(Icons.search),
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/searchbackground.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Currysearchmap()),
                      );
                    },
                    style: style,
                    child: const Text('地図からカリ〜を探す'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('近くに$currysearchcount件のカリーショップがあるでしょう〜'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset(
                'assets/images/kumaluacon.png',
                width: 100,
                height: 100,
              ),
            ),
            // カリータイプから探す
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'カリータイプから探す',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(currytypeimage.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              // タップされたら遷移
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CurryTypeSearchListView(
                                    curryType: curryTypeText[index],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(currytypeimage[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    curryTypeText[index],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 最近オープンしたカリーショップ
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '最近オープンしたカリーショップ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(opencurryshop.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(opencurryshop[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // 店舗名
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 150, // 固定したい横幅を指定
                                  child: Text(
                                    opencurryshoptext[index],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow
                                        .ellipsis, // テキストがはみ出た場合に省略記号で表示する
                                    maxLines: 1, // 最大行数を指定
                                  ),
                                ),
                                // カリージャンル
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 150, // 固定したい横幅を指定
                                  child: Row(
                                    children: [
                                      Text(
                                        opencurryshopgenre[index],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow
                                            .ellipsis, // テキストがはみ出た場合に省略記号で表示する
                                        maxLines: 1, // 最大行数を指定
                                      ),
                                      // 文字の間のハイフン
                                      const SizedBox(height: 8),
                                      const Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // 店舗所在
                                      const SizedBox(height: 8),
                                      Text(
                                        opencurryshoplocation[index],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow
                                            .ellipsis, // テキストがはみ出た場合に省略記号で表示する
                                        maxLines: 1, // 最大行数を指定
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
