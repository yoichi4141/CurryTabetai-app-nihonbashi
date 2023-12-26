import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/postviewmodel.dart';
import 'package:flutter/material.dart';

//Googleマップを表示させますよ〜
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Currysearchmap extends StatefulWidget {
  const Currysearchmap({Key? key}) : super(key: key);

  @override
  State<Currysearchmap> createState() => CurrysearchmapState();
}

class CurrysearchmapState extends State<Currysearchmap> {
  late GoogleMapController _mapController;
  late PostViewModel postViewModel = PostViewModel();
  bool _isSelected = false; //トグルボタンの初期選択状態
  List<String> nearShopList = []; // 近くの店舗リスト（テキストフィールド用）

  final _pageController = PageController(
    viewportFraction: 0.85, //0.85くらいで端っこに別のカードが見えてる感じになる
  );
  //TODO現在地から５Km圏内のカリーショップを表示させるようにする（タイルとピン）
  //初期位置をVahonに設定してます
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(35.68184103085021, 139.77912009529513),
    zoom: 18,
  );

  @override
  void initState() {
    super.initState();
    postViewModel = PostViewModel(); // PostViewModelのインスタンスを初期化
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // AppBarの背景を透明にする

      appBar: AppBar(
        backgroundColor: Colors.transparent, // 背景を透明にする
        elevation: 0, // 影を削除する
        title: const Text('カリーログ投稿🍛'),

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '行きたいカリーショップを入力',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 0, // ボーダーの幅をゼロに設定
                        style: BorderStyle.none, // ボーダースタイルを設定
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _mapSection(),
          _cardSection(),
        ],
      ),
    );
  }

  Widget _mapSection() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      markers: postViewModel.nearShopList.map(
        (selectedShop) {
          return Marker(
            markerId: MarkerId(selectedShop.uid),
            position: LatLng(selectedShop.lat, selectedShop.lng),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () async {
              //タップしたマーカー(shop)のindexを取得
              final index = postViewModel.nearShopList
                  .indexWhere((nearShop) => nearShop == selectedShop);
              //タップしたお店がPageViewで表示されるように飛ばす
              _pageController.jumpToPage(index);
            },
          );
        },
      ).toSet(),
    );
  }

  Widget _cardSection() {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: PageView(
        onPageChanged: (int index) async {
          //スワイプ後のページのお店を取得
          final selectedShop = postViewModel.nearShopList.elementAt(index);
          //現在のズームレベルを取得
          final zoomLevel = await _mapController.getZoomLevel();
          //スワイプ後のお店の座標までカメラを移動
          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(selectedShop.lat, selectedShop.lng),
                zoom: zoomLevel,
              ),
            ),
          );
        },
        controller: _pageController,
        children: _shopTiles(),
      ),
    );
  }

  List<Widget> _shopTiles() {
    final shopTiles = postViewModel.nearShopList.map(
      (nearShop) {
        return Stack(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 200, //ここでカード長さ
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // テキスト
                      Text(
                        nearShop.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        nearShop.location,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 8), // テキストと画像の間隔を調整するためのスペース
                      Row(
                        children: [
                          Image.network(
                            nearShop.image,
                            width: 140,
                            height: 100, // 画像の高さを調整
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 13),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ジャンル:${nearShop.genre}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(width: 8), // スペース
                              Text(
                                '営業時間:${nearShop.time}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              //TODOボタンの状態に応じてのファイアーベースを実装
              child: ToggleButtons(
                isSelected: [_isSelected],
                onPressed: (int index) {
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
                borderRadius: BorderRadius.circular(0),
                borderWidth: 0,
                selectedColor: Colors.white,
                children: const <Widget>[
                  Icon(Icons.star),
                ],
              ),
            ),
          ],
        );
      },
    ).toList();
    return shopTiles;
  }
}
