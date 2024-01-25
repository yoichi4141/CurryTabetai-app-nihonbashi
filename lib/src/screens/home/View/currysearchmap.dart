import 'package:currytabetaiappnihonbashi/src/screens/home/View/autocomplete.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/storedetailhome.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/mapviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//Googleマップを表示させますよ〜
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Currysearchmap extends StatefulWidget {
  const Currysearchmap({
    Key? key,
  }) : super(key: key);

  @override
  State<Currysearchmap> createState() => CurrysearchmapState();
}

class CurrysearchmapState extends State<Currysearchmap> {
  late GoogleMapController _mapController;
  late MapViewModel mapViewModel; // postViewModelをプロパティとして追加provider関連
  bool _isSelected = false; //トグルボタンの初期選択状態
  List<String> nearShopList = []; // 近くの店舗リスト（テキストフィールド用）
  bool isSelected = true;

  final _pageController = PageController(
    viewportFraction: 0.85, //0.85くらいで端っこに別のカードが見えてる感じになる
  );

  // 初期位置を格納する変数
  late Future<CameraPosition> _initialCameraPositionFuture;

  @override
  void initState() {
    super.initState();
    // MapViewModelのインスタンスを取得
    mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    // hotpepperApiを呼び出す
    mapViewModel.hotpepperApi();
    // 初期位置を取得する関数を呼び出す
    _initialCameraPositionFuture = _getInitialLocation();
  }

// 現在地を取得する関数(LocationPermissionに応じた分岐)
  Future<CameraPosition> _getInitialLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
//位置情報の取得をOKした場合ロケーションを取得する
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high); //取得ロケーションの精度
        print('Got position: ${position.latitude}, ${position.longitude}');

        return CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );
      } else {
        // 位置情報が許可されていない場合はてきとうにVashonの位置を返す
        return CameraPosition(
          target: LatLng(35.68184103085021, 139.77912009529513),
          zoom: 15,
        );
      }
    } catch (e) {
      // エラーが発生した場合は位置情報が許可されていない場合はてきとうにVashonの位置を返す
      print(e.toString());
      return CameraPosition(
        target: LatLng(35.68184103085021, 139.77912009529513),
        zoom: 15,
      );
    }
  }

//MapViewModelのインスタンスを取得している（これないとカードが描写されない）//TODOリバーポットにする？
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mapViewModel = Provider.of<MapViewModel>(context, listen: true);
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: GestureDetector(
                  onTap: () {
                    // コンテナがタップされたらオートコンプリートページに遷移
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AutocompleteExample(),
                      ),
                    );
                  },
                  child: Container(
                    height: 56.0, // GestureDetectorの高さを設定
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 220, 220)),
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white, // 背景色を白に設定
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Icon(Icons.search,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            '行きたいカリーショップを入力',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
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
    //_initialCameraPositionFutureの完了を待ってから構築するために FutureBuilderにしている
    return FutureBuilder<CameraPosition>(
        future: _initialCameraPositionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final initialCameraPosition = snapshot.data!;
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              myLocationEnabled: true,
              markers: mapViewModel.nearShopList.map(
                (selectedShop) {
                  return Marker(
                    markerId: MarkerId(selectedShop.id),
                    position: LatLng(selectedShop.lat, selectedShop.lng),
                    icon: BitmapDescriptor.defaultMarker,
                    onTap: () async {
                      //タップしたマーカー(shop)のindexを取得
                      final index = mapViewModel.nearShopList
                          .indexWhere((nearShop) => nearShop == selectedShop);
                      //タップしたお店がPageViewで表示されるように飛ばす
                      _pageController.jumpToPage(index);
                    },
                  );
                },
              ).toSet(),
            );
          }
        });
  }

  Widget _cardSection() {
    return InkWell(
      onTap: () {
        //スワイプ中だと要素が小数点になるっぽいのでround
        final selectedShop =
            mapViewModel.nearShopList.elementAt(_pageController.page!.round());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                StoredetailHome(id: selectedShop.id, name: selectedShop.name),
          ),
        );
      },
      child: Container(
        height: 200,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: PageView(
          onPageChanged: (int index) async {
            //スワイプ後のページのお店を取得
            final selectedShop = mapViewModel.nearShopList.elementAt(index);
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
      ),
    );
  }

  List<Widget> _shopTiles() {
    final shopTiles = mapViewModel.nearShopList.map(
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
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        nearShop.address,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Image.network(
                            nearShop.photo,
                            width: 140,
                            height: 100, // 画像の高さを調整
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    '投稿数 100',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width: 8), // スペース

                                  const Text(
                                    'いいね 100',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text('カリージャンル',
                                      style: TextStyle(fontSize: 9)),
                                  SizedBox(height: 0),
                                  Text(
                                    '${nearShop.genre}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: 140,
                                    height: 40,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('🍛インドカリーある',
                                                style: TextStyle(
                                                    fontSize: 6.0,
                                                    color: isSelected
                                                        ? Colors.grey
                                                        : Colors.black)),
                                            Text('🍚ビリヤニある',
                                                style: TextStyle(
                                                    fontSize: 6.0,
                                                    color: isSelected
                                                        ? Colors.grey
                                                        : Colors.black)),
                                            Text('🍛ミールスある',
                                                style: TextStyle(
                                                    fontSize: 6.0,
                                                    color: isSelected
                                                        ? Colors.grey
                                                        : Colors.black)),
                                            Text('🫓ナンある',
                                                style: TextStyle(
                                                    fontSize: 6.0,
                                                    color: isSelected
                                                        ? Colors.grey
                                                        : Colors.black)),
                                          ],
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('🎧インドBGMある',
                                                style: TextStyle(
                                                    fontSize: 6.0,
                                                    color: isSelected
                                                        ? Colors.grey
                                                        : Colors.black)),
                                            Text('📽️インドムービー鑑賞可',
                                                style: TextStyle(
                                                    fontSize: 6.0,
                                                    color: isSelected
                                                        ? Colors.grey
                                                        : Colors.black)),
                                            Text('🇮🇳ヒンディー語OK',
                                                style: TextStyle(
                                                    fontSize: 6.0,
                                                    color: isSelected
                                                        ? Colors.grey
                                                        : Colors.black)),
                                            Text('🇯🇵日本語difficult',
                                                style: TextStyle(
                                                    fontSize: 6.0,
                                                    color: isSelected
                                                        ? Colors.grey
                                                        : Colors.black)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
              top: 8,
              right: 8,
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
