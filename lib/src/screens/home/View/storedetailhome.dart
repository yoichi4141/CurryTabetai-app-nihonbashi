import 'package:currytabetaiappnihonbashi/src/screens/home/View/StoredetailPage.dart';
import 'package:flutter/material.dart';

class StoredetailHome extends StatefulWidget {
  const StoredetailHome({Key? key, required String id}) : super(key: key);

  @override
  State<StoredetailHome> createState() => _StoredetailHomeState();
}

class _StoredetailHomeState extends State<StoredetailHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("ナマステ"),
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
              Tab(text: 'カリー食べたヨ'),
              Tab(text: 'अधूरा'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StoreDetailPage(),

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
