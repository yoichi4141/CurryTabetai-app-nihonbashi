import 'package:currytabetaiappnihonbashi/src/Util/API/Service/shopservice.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_ShopPage_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_timeline_view.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/store_Detail_ShopPage_Google_Viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/store_Details_HotpepperViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/view/make_post_View.dart';
import 'package:flutter/material.dart';

class StoredetailHome extends StatefulWidget {
  final String id;
  final String name;

  const StoredetailHome({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<StoredetailHome> createState() => StoredetailHomeState();
}

class StoredetailHomeState extends State<StoredetailHome> {
  late StoreDetailsViewModel _storeDetailsViewModel;
  late GoogleStoreDetailViewModel _googleStoreDetailViewModel;

  @override
  void initState() {
    super.initState();
    _storeDetailsViewModel = StoreDetailsViewModel();
    _googleStoreDetailViewModel = GoogleStoreDetailViewModel();

    Future.delayed(Duration.zero, () {
      _fetchData(widget.id);
      _fetchGoogleData(widget.name);
    });
  }

//idをViewmodelに渡す関数
  Future<void> _fetchData(String id) async {
    try {
      // widget.idを使ってViewModelにデータの取得をリクエスト
      await _storeDetailsViewModel.fetchData(id: id);
      // データが変更された場合、notifyListenersを呼ぶ
      setState(
          () {}); //ウイジェットツリーの再構築（初回描写では値がなかったため※２回目のStoreDetailsViewModelのインスタンスに値が格納されていた多分更新のタイミングが早い）
    } catch (error) {
      // エラーハンドリング
      print('Error: $error');
    }
  }

  Future<void> _fetchGoogleData(String name) async {
    try {
      await _googleStoreDetailViewModel.googlefetchData(name: name);
      setState(() {});
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    int initialTabIndex = 0;
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      initialTabIndex = arguments as int;
    }

    return DefaultTabController(
      length: 2,
      initialIndex: initialTabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
              // シェア機能の追加
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.black, // 選択されたタブのテキスト色を赤に変更
            unselectedLabelColor: Colors.black, // 非選択のタブのテキスト色を黒に変更

            tabs: [
              Tab(text: '店舗情報'),
              Tab(text: '投稿'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StoreDetailPage(
              storeDetailsViewModel: _storeDetailsViewModel,
            ),

            // タブ2のコンテンツ
            StoreDetailTimeline(
              userId: '',
              shopId: widget.id,
              shopName: widget.name,
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 60,
              child: FloatingActionButton.extended(
                heroTag: 'いきたいボタン＋カリーログを投稿ボタン',
                onPressed: () {
                  //TODO　shopにいきたいとして追加する
                },
                label: Text(
                  'いきたい',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 角丸を設定
                ),
                elevation: 0, // 影をなくす
              ),
            ),

            SizedBox(
              width: 6,
            ), // ボタン間のスペースを設定

            SizedBox(
              width: 240,
              height: 60,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MakePostView(
                              data: {
                                'name': widget.name,
                                'id': widget.id,
                              },
                            ),
                        settings: RouteSettings(arguments: 1)),
                  );
                },
                label: Text(
                  'カリーログを投稿',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: const Color.fromARGB(255, 75, 180, 79),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 角丸を設定
                ),
                elevation: 0, // 影をなくす
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
      ),
    );
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // ここでボタンの位置を定義します
    return Offset(
      -14,
      scaffoldGeometry.scaffoldSize.height - 90,
    );
  }
}
