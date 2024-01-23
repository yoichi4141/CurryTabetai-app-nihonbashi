import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/storedetailsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class StoreDetailPage extends StatefulWidget {
  final StoreDetailsViewModel storeDetailsViewModel;

  const StoreDetailPage({
    Key? key,
    required this.storeDetailsViewModel,
  }) : super(key: key);

  @override
  State<StoreDetailPage> createState() => StoreDetailPageState();
}

class StoreDetailPageState extends State<StoreDetailPage> {
  late StoreDetailsViewModel storeDetailsViewModel;
  late GoogleMapController _DetailmapController;
  late double lat;
  late double lng;
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    storeDetailsViewModel = widget.storeDetailsViewModel;

    // 遅延処理を追加
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        // ここにウィジェットの描画を設定する
      });
    });
  }

  Widget _mapImage() {
    double initialLat =
        widget.storeDetailsViewModel.storedetailinformation.isNotEmpty
            ? widget.storeDetailsViewModel.storedetailinformation[0].lat
            : 0.0;
    double initialLng =
        widget.storeDetailsViewModel.storedetailinformation.isNotEmpty
            ? widget.storeDetailsViewModel.storedetailinformation[0].lng
            : 0.0;

    return Container(
      height: 200,
      width: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(initialLat, initialLng),
          zoom: 16.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _DetailmapController = controller;
        },
        myLocationEnabled: true,
        markers: widget.storeDetailsViewModel.storedetailinformation.map(
          (shopData) {
            return Marker(
              markerId: MarkerId(shopData.id),
              position: LatLng(shopData.lat, shopData.lng),
              icon: BitmapDescriptor.defaultMarker,
            );
          },
        ).toSet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StoreDetailsViewModel>(
        builder: (context, storeDetailsViewModel, child) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget
                        .storeDetailsViewModel.storedetailinformation.isNotEmpty
                    ? [
                        SizedBox(height: 12),
                        Text(
                          ' ${widget.storeDetailsViewModel.storedetailinformation[0].name}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'カレーある${widget.storeDetailsViewModel.storedetailinformation[0].genre}',
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                '投稿数:10000',
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'いいね:100000',
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10.0), // 任意の角丸の半径
                                child: Image.network(
                                  '${widget.storeDetailsViewModel.storedetailinformation[0].photo}',
                                  width: 200.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10.0), // 任意の角丸の半径
                                child: Image.network(
                                  '${widget.storeDetailsViewModel.storedetailinformation[0].photo}',
                                  width: 200.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10.0), // 任意の角丸の半径
                                child: Image.network(
                                  '${widget.storeDetailsViewModel.storedetailinformation[0].photo}',
                                  width: 200.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Divider(color: Colors.grey, thickness: 0.5), // 線を挿入

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('🍛インドカリーある',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black)),
                                Text('🍚ビリヤニある',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black)),
                                Text('🍛ミールスある',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black)),
                                Text('🫓ナンある',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black)),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('🎧インドBGMある',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black)),
                                Text('📽️インドムービー鑑賞可',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black)),
                                Text('🇮🇳ヒンディー語OK',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black)),
                                Text('🇯🇵日本語difficult',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black)),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 12),

                        Text(
                          '店舗情報',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 150,
                          width: 360,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 230, 230, 230), // グレイの色
                            borderRadius: BorderRadius.circular(6), // 角丸
                          ),
                        ),

                        SizedBox(height: 12),
                        Divider(color: Colors.grey, thickness: 0.5), // 線を挿入

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // 左右に均等に配置
                              children: [
                                Text(
                                  '投稿',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '全て見る',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1), // ボーダー
                                      borderRadius:
                                          BorderRadius.circular(6), // 角丸
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1), // ボーダー
                                      borderRadius:
                                          BorderRadius.circular(6), // 角丸
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1), // ボーダー
                                      borderRadius:
                                          BorderRadius.circular(6), // 角丸
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1), // ボーダー
                                      borderRadius:
                                          BorderRadius.circular(6), // 角丸
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                        SizedBox(height: 12),
                        Center(
                          child: Text(
                            '基本情報',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Center(child: _mapImage()),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                            Text(
                              ' 住所:グーグルAPIから',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                            Text(
                              ' TEL:グーグルAPIから',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                            Text(
                              ' HP:グーグルAPIから',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                            Text(
                              ' 定休日:グーグルAPIから',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                            Text(
                              ' 営業時間:グーグルAPIから',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                            Text(
                              ' 料金:グーグルAPIから',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                            Text(
                              ' アクセス:グーグルAPIから',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.grey, thickness: 0.5), // 線を挿入
                            Text(
                              ' 駐車場:グーグルAPIから',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ]
                    : [Text('')],
              ),
            ),
          );
        },
      ),
    );
  }
}
