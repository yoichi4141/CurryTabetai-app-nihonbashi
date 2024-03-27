import 'package:currytabetaiappnihonbashi/src/screens/home/View/curryTypeSearchListView.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/curry_Map_Search_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/home_Search_Page_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_Home_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/homeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
//権限管理系のパッケージ今回は位置情報

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocationPermission permission;
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _getLocationPermission(); // 位置情報の許可をリクエストする関数を呼び出す
    viewModel = HomeViewModel("good");
  }

  // 位置情報の許可をリクエストする関数
  Future<void> _getLocationPermission() async {
    permission = await Geolocator.requestPermission();
    print('位置情報の許可状態: $permission'); // 許可状態をプリントする
    setState(() {}); // 許可状態が取得できたら画面を更新する
  }

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
      'coming soon~',
      'coming soon~',
      'coming soon~',
      'coming soon~',
      'coming soon~',
      'coming soon~',
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
      '',
      '',
      '',
      '',
      '',
      '',
    ];

    // ElevatedButtonの外側で_checkPermissionAndNavigate関数を定義する
    void _checkPermissionAndNavigate() {
      if (permission == LocationPermission.whileInUse) {
        // 位置情報の権限が許可された場合の遷移処理
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Currysearchmap(
              shopId: '',
            ),
          ),
        );
      } else {
        // 位置情報の権限が拒否された場合の処理
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('位置情報の利用が許可されていません'),
            content: const Text('地図からカリ〜を探すには、位置情報の利用を許可してください'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => viewModel,
            child: Consumer<HomeViewModel>(builder: (context, viewModel, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 64),
                      child: Image(
                        image: AssetImage('assets/images/homekari2.png'),
                        width: 260,
                        height: 90,
                      ),
                    ),
                    //TODO実装する

                    Padding(
                      padding: EdgeInsets.only(
                          left: 24.0, right: 24.0), // 左右のパディングを追加
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HomeCurrySearchView(), // 遷移先のページを指定
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.zero,
                          height: 49.0, // GestureDetectorの高さを設定
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 220, 220, 220)),
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white, // 背景色を白に設定
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Icon(Icons.search,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  '行きたいカリーショップを探す',
                                  // 他のスタイル設定を行う場合はここに追加
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/searchbackground.png',
                                fit: BoxFit.cover,
                                width: 360,
                                height: 180,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // ここにElevatedButtonを配置します
                          bottom: 90, // ボタンの位置を調整するための適切な値を指定してください
                          child: ElevatedButton(
                            onPressed: () async {
                              // ボタンが押されたときにチェック関数を実行する
                              _checkPermissionAndNavigate();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // ボタンの背景色
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              '地図からカリ〜を探す',
                              style:
                                  TextStyle(color: Colors.white), // テキストの色を白に設定
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '近くに$currysearchcount件のカリーショップがありますね〜',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),

                    // カリータイプから探す
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        alignment: AlignmentDirectional.topStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6),

                            Divider(
                                color: const Color.fromARGB(255, 211, 211, 211),
                                thickness: 0.5), // 線を挿入
                            const Text(
                              'カリータイプから探す',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(currytypeimage.length,
                                    (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // タップされたら遷移
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CurryTypeSearchListView(
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
                                                image: AssetImage(
                                                    currytypeimage[index]),
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

                    // 最近いい感じのカリーショップ
                    const SizedBox(height: 6),
                    Divider(
                        color: Color.fromARGB(255, 211, 211, 211),
                        thickness: 0.5), // 線を挿入

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: AlignmentDirectional.topStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '最近いい感じのカリーショップ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(opencurryshop.length,
                                    (index) {
                                  return GestureDetector(
                                      onTap: () {
                                        // 遷移
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                StoredetailHome(
                                              id: viewModel.response.results
                                                      .shop[index].id ??
                                                  "",
                                              name: viewModel.response.results
                                                  .shop[index].name,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    viewModel.response.results
                                                            .shop.isEmpty
                                                        ? 'URL_TO_DUMMY_IMAGE'
                                                        : viewModel
                                                                .response
                                                                .results
                                                                .shop[index]
                                                                .photo
                                                                ?.pc
                                                                .l ??
                                                            '',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            // 店舗名
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: 150, // 固定したい横幅を指定
                                              child: Text(
                                                viewModel.response.results.shop
                                                        .isEmpty
                                                    ? 'URL_TO_DUMMY_IMAGE'
                                                    : viewModel.response.results
                                                        .shop[index].name,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  // 店舗所在
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    opencurryshoplocation[
                                                        index],
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                      ));
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //投稿数が多いカリーショップ
                    const SizedBox(height: 6),
                    Divider(
                        color: Color.fromARGB(255, 211, 211, 211),
                        thickness: 0.5),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: AlignmentDirectional.topStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '最近話題っぽいカリーショップ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(opencurryshop.length,
                                    (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  opencurryshop[index]),
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
              );
            })));
  }
}
