import 'package:currytabetaiappnihonbashi/src/screens/home/View/curry_Map_Autocomplete_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_Home_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map_Placeresult_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SearchLocationMap extends StatefulWidget {
  final double destinationLat;
  final double destinationLng;

  const SearchLocationMap(
      {Key? key, required this.destinationLat, required this.destinationLng})
      : super(key: key);

  @override
  State<SearchLocationMap> createState() => SearchLocationMapState();
}

class SearchLocationMapState extends State<SearchLocationMap> {
  late GoogleMapController _mapController;
  late PlaceResultViewModel placeResultViewModel; //店舗情報を取得するViewmodel

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
    // PlaceResultViewModelのインスタンスを取得
    placeResultViewModel =
        Provider.of<PlaceResultViewModel>(context, listen: false);
    // 初期位置を取得する関数を呼び出す
    _initialCameraPositionFuture = _getDestinationLocation(
      widget.destinationLat,
      widget.destinationLng,
    );

    //近くの店舗情報の取得
    _fetchNearbyPlaces();
  }

  Future<CameraPosition> _getDestinationLocation(
    double destinationLat,
    double destinationLng,
  ) async {
    return CameraPosition(
      target: LatLng(destinationLat, destinationLng),
      zoom: 15,
    );
  }

  void _fetchNearbyPlaces() {
    placeResultViewModel.placeResultApi(
        locationList: [widget.destinationLat, widget.destinationLng]);
  }

  //MapViewModelのインスタンスを取得している（これないとカードが描写されない）//TODOリバーポットにする？
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    placeResultViewModel =
        Provider.of<PlaceResultViewModel>(context, listen: true);
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
                        builder: (context) => const AutocompleteExample(),
                      ),
                    );
                  },
                  child: Container(
                    height: 56.0, // GestureDetectorの高さを設定
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 220, 220)),
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
                            '場所でカリーを検索',
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
          return const Center(child: CircularProgressIndicator());
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
            markers: {
              // 現在地のマーカーはすでにカリーサーチマップで使用しているのでのちほど両方画像に変える
              Marker(
                markerId: const MarkerId('userLocation'),
                position: LatLng(initialCameraPosition.target.latitude,
                    initialCameraPosition.target.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                infoWindow: const InfoWindow(title: 'Your Location'),
              ),
              // 近くの店舗のマーカーを追加
              ...placeResultViewModel.nearbyPlaces.map((selectedShop) {
                return Marker(
                  markerId: MarkerId(selectedShop.id),
                  position: LatLng(selectedShop.lat, selectedShop.lng),
                  icon: BitmapDescriptor.defaultMarker,
                  onTap: () async {
                    //タップしたマーカー(shop)のindexを取得
                    final index = placeResultViewModel.nearbyPlaces
                        .indexWhere((nearShop) => nearShop == selectedShop);
                    //タップしたお店がPageViewで表示されるように飛ばす
                    _pageController.jumpToPage(index);
                  },
                );
              }),
            },
          );
        }
      },
    );
  }

  Widget _cardSection() {
    return InkWell(
      onTap: () {
        //スワイプ中だと要素が小数点になるっぽいのでround
        final selectedShop = placeResultViewModel.nearbyPlaces
            .elementAt(_pageController.page!.round());
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
            final selectedShop =
                placeResultViewModel.nearbyPlaces.elementAt(index);
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
    final shopTiles = placeResultViewModel.nearbyPlaces.map(
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
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.network(
                            nearShop.photo,
                            width: 140,
                            height: 100, // 画像の高さを調整
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '投稿数 100',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(width: 8), // スペース

                                  Text(
                                    'いいね 100',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  const Text('カリージャンル',
                                      style: TextStyle(fontSize: 9)),
                                  const SizedBox(height: 0),
                                  Text(
                                    '${nearShop.genre}',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: 140,
                                    height: 40,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 0),
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
                                        const SizedBox(width: 8),
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
