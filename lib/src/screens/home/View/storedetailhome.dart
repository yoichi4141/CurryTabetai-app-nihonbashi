import 'package:currytabetaiappnihonbashi/src/screens/home/View/StoredetailPage.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/googleStoreDetailViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/storedetailsViewModel.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
              // TODO: シェア機能を追加
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.black, // 選択されたタブのテキスト色を赤に変更
            unselectedLabelColor: Colors.black, // 非選択のタブのテキスト色を黒に変更

            tabs: [
              Tab(text: '店舗情報'),
              Tab(text: '投稿'),
              Tab(text: 'अधूरा'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StoreDetailPage(
              storeDetailsViewModel: _storeDetailsViewModel,
            ),

            // タブ2のコンテンツ
            Icon(Icons.directions_transit),

            // タブ3のコンテンツ
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
