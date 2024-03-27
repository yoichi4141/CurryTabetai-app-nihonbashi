import 'package:currytabetaiappnihonbashi/src/screens/home/View/curry_Map_Searchlocation.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_Home_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map_LocationAPI_ViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map%20SearchshopAPI_viewmodel.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(); // ここで初期化する
    _scrollController = ScrollController();

    _initData();
  }

  Future<void> _initData() async {
    await searchViewModel.hotpepperSearch();
  }

  @override
  Widget build(BuildContext context) {
    // _initData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('アルティメットカリーロケーションサーチ🍛🔍',
            style: TextStyle(color: Colors.black)),
        titleTextStyle: const TextStyle(fontSize: 14),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          controller: _scrollController, // ScrollControllerを設定

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (searchViewModel.searchShopList.isEmpty) {
                    searchViewModel.hotpepperSearch(userEnteredText: '');
                    return const Iterable<String>.empty();
                  }

                  return searchViewModel.searchShopList
                      .where((SearchShop shop) => shop.name
                          .contains(textEditingValue.text.toLowerCase()))
                      .map((SearchShop shop) => shop.name);
                },
                fieldViewBuilder: (
                  context,
                  controller,
                  focusNode,
                  onFieldSubmitted,
                ) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: textEditingController,
                        onChanged: (String text) async {
                          await Future.delayed(
                              const Duration(milliseconds: 500));

                          searchViewModel.hotpepperSearch(
                              userEnteredText: text);
                        },
                        focusNode: focusNode,
                        onFieldSubmitted: (String value) {
                          onFieldSubmitted();
                          textEditingController.clear();
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 4.0,
                              bottom: 4.0,
                              left: 16.0,
                              right: 16.0), // 上部の余白を微調整

                          hintText: ' 駅名とか地名とか入れてみるヨ〜🍛🔍',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 18, 3, 3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 167, 167, 167)),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                onSelected: (String selectedShopName) {
                  SearchShop selectedShop =
                      searchViewModel.searchShopList.firstWhere(
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(''),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            String searchText = textEditingController.text;

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

                            // ignore: use_build_context_synchronously
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
                              minimumSize: const Size(300, 40)),
                          child: const Text(
                            '検索',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
