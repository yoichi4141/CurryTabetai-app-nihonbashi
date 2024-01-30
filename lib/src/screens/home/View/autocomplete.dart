import 'package:currytabetaiappnihonbashi/src/screens/home/View/currysearchmap.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/searchlocationmap.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/storedetailhome.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/locationViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/searchViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/postviewmodel.dart';
import 'package:flutter/material.dart';

class AutocompleteExample extends StatefulWidget {
  const AutocompleteExample({Key? key}) : super(key: key);

  @override
  State<AutocompleteExample> createState() => _AutocompleteExampleState();
}

class _AutocompleteExampleState extends State<AutocompleteExample> {
  final SearchViewModel searchViewModel = SearchViewModel();
  final LocationViewModel locationViewModel =
      LocationViewModel(); //placeNameのやつ
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();

    _initData();
  }

  Future<void> _initData() async {
    await searchViewModel.hotpepperSearch();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final SearchViewModel searchViewModel = SearchViewModel();
    final LocationViewModel locationViewModel = LocationViewModel();
    TextEditingController textEditingController;

    Future<void> _initData() async {
      await searchViewModel.hotpepperSearch();
      textEditingController = TextEditingController();
    }

    _initData(); // Call _initData here or in initState depending on your needs

    return Scaffold(
      appBar: AppBar(
        title: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (searchViewModel.searchShopList.isEmpty) {
              searchViewModel.hotpepperSearch(userEnteredText: '');
              return const Iterable<String>.empty();
            }

            return searchViewModel.searchShopList
                .where((SearchShop shop) =>
                    shop.name.contains(textEditingValue.text.toLowerCase()))
                .map((SearchShop shop) => shop.name);
          },
          fieldViewBuilder: (
            context,
            textEditingController,
            focusNode,
            onFieldSubmitted,
          ) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: textEditingController,
                  onChanged: (String text) async {
                    await Future.delayed(Duration(milliseconds: 500));
                    searchViewModel.hotpepperSearch(userEnteredText: text);
                  },
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                    textEditingController.clear();
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 16.0,
                        right: 16.0), // 上部の余白を微調整

                    hintText: '店舗名/場所でカリーを検索',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 3, 3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 167, 167, 167)),
                    ),

                    suffix: ElevatedButton(
                      onPressed: () async {
                        print('ボタンが押されました！');
                        String searchText = textEditingController.text;
                        print('placeNameボタンのところ: $searchText');
                        await locationViewModel.loadLocationData(
                          placeName: searchText,
                        );

                        double destinationLat =
                            locationViewModel.locationList.isNotEmpty
                                ? locationViewModel.locationList[0]
                                : 0.0;

                        double destinationLng =
                            locationViewModel.locationList.isNotEmpty
                                ? locationViewModel.locationList[1]
                                : 0.0;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchLocationMap(
                              destinationLat: destinationLat,
                              destinationLng: destinationLng,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        '検索',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          onSelected: (String selectedShopName) {
            SearchShop selectedShop = searchViewModel.searchShopList.firstWhere(
              (shop) => shop.name == selectedShopName,
              orElse: () => SearchShop(id: '', name: ''),
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoredetailHome(
                  id: selectedShop.id,
                  name: selectedShop.name,
                ),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0, // 下方向の位置を調整
            right: 0, // 右方向の位置を調整
            child: Column(
              children: [
                Row(
                  children: [],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
