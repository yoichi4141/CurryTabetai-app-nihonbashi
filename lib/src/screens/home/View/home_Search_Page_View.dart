import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_Home_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map_LocationAPI_ViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/home_Search_Page_Listdete_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map%20SearchshopAPI_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCurrySearchView extends StatefulWidget {
  const HomeCurrySearchView({Key? key}) : super(key: key);

  @override
  State<HomeCurrySearchView> createState() => _HomeCurrySearchViewState();
}

class _HomeCurrySearchViewState extends State<HomeCurrySearchView>
    with SingleTickerProviderStateMixin {
  final SearchViewModel searchViewModel = SearchViewModel();
  final LocationViewModel locationViewModel =
      LocationViewModel(); //placeNameのやつ
  late TextEditingController textEditingController;
  late TabController _tabController;
  final _tab = <Tab>[
    const Tab(text: '都道府県'),
    const Tab(text: '条件'),
  ];

//オートコンプリートとTabController初期化している
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(); // ここで初期化する
    _initData();
    _tabController = TabController(vsync: this, length: _tab.length);
  }

  //オートコンプリートのやつ
  Future<void> _initData() async {
    await searchViewModel.hotpepperSearch();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // オートコンプリート
            Autocomplete<String>(
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
                controller,
                focusNode,
                onFieldSubmitted,
              ) {
                return Column(
                  children: [
                    TextFormField(
                      controller: textEditingController,
                      onChanged: (String text) async {
                        print('homecurrysearch入力テキスト: $text');
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
                        contentPadding: const EdgeInsets.only(
                            top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                        hintText: ' 駅名とか地名とか入れてみるヨ〜🍛🔍',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 18, 3, 3)),
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
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '都道府県'),
            Tab(text: '条件'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SearchTabContent(),
          ConditionTabContent(),
        ],
      ),
      resizeToAvoidBottomInset: true, // キーボードが表示されるときにウィジェットが自動的に位置を変更する
      bottomNavigationBar: Footer(),
    );
  }
}

//都道府県タブのクラス
class SearchTabContent extends StatefulWidget {
  @override
  State<SearchTabContent> createState() => _SearchTabContentState();
}

class _SearchTabContentState extends State<SearchTabContent> {
  String? selectedRegion;
  String? selectedPrefecture;
  String? selectedRailway;
  String? selectedStation;

  bool? selectedRegionCheckbox; // チェックボックスの状態を保持するフィールド
  bool? selectedPrefectureCheckbox; // selectedPrefectureCheckboxの初期値
  bool? selectedRailwayCheckbox = false; // selectedRailwayCheckboxの初期値をここで設定
  bool? selectedStationCheckbox = false; // selectedStationCheckboxの初期値をここで設定
  bool showCheckboxes = false; // チェックボックスの表示状態を管理するフラグ

  @override
  void initState() {
    super.initState();
    selectedRegion = '';
    selectedPrefecture = '';
    selectedRailway = '';
    selectedStation = '';
    selectedRegionCheckbox = false;
    selectedPrefectureCheckbox = false;
  }

  List<String> regionsList = SearchTab.regionsList;
  Map<String, List<Map<String, dynamic>>> prefectureList =
      SearchTab.prefectureList;
  Map<String, List<Map<String, dynamic>>> railwayList = SearchTab.railwayList;
  Map<String, List<Map<String, dynamic>>> stationList = SearchTab.stationList;
  String? selectedStationApiKeyword;
  String? selectedrRailwayApiKeyword;

  //TODO沿線と駅のメソッドに変更する
  void handlerailwayCheckboxTap(bool? checked, String selectedRegionParam) {
    setState(() {
      selectedRailway = selectedRegionParam;
      selectedRailwayCheckbox = checked ?? false;

      // 新しい値が正しいかどうかを確認
      if (selectedRailwayCheckbox!) {
        // selectedRailwayCheckboxがtrueの場合のみselectedStationApiKeywordを更新
        selectedStationApiKeyword = selectedRegionParam;
        handleRailwaySelection(selectedRegionParam, selectedRegionCheckbox!);
      }

      print('selectedRailwayCheckbox: $selectedRailwayCheckbox');
      print('selectedStationCheckbox: $selectedStationCheckbox');
    });
  }

  void handleStationCheckboxTap(bool? checked, String selectedRegionParam) {
    setState(() {
      selectedStation = selectedRegionParam;
      selectedStationCheckbox = checked ?? false;

      // 新しい値が正しいかどうかを確認
      if (selectedStationCheckbox!) {
        // selectedStationCheckboxがtrueの場合のみselectedrRailwayApiKeywordを更新
        selectedrRailwayApiKeyword = selectedRegionParam;
        handleStationSelection(selectedRegionParam, selectedRegionCheckbox!);
      }

      print('selectedStationCheckbox: $selectedStationCheckbox');
    });
  }

//TODO沿線と駅のメソッドに変更するhandleStationCheckboxTapのメソッドを追加する

  void handleRailwaySelection(String selectedRegionParam, bool checked) {
    // region を selectedRegion に変更
    if (checked) {
      _fetchStationList(selectedRegionParam); // region を selectedRegion に変更
      print('沿線のチェックボックスがタップされました。');
    }
  }

  void handleStationSelection(String selectedRegionParam, bool checked) {
    // region を selectedRegion に変更
    if (checked) {
      _fetchStationList(selectedRegionParam); // region を selectedRegion に変更
      print('駅のチェックボックスがタップされました。');
    }
  }

// 鉄道チェックボックスture処理
  void _fetchRailwayList(String selectedRegionParam) {
    // region を selectedRegion に変更
    List<Map<String, dynamic>>? railways =
        railwayList[selectedRegion]; // region を selectedRegion に変更
    if (railways != null) {
      print('鉄道リストが取得されました。');
      for (Map<String, dynamic> railwayMap in railways) {
        String railway = railwayMap['value'];
        print('鉄道: $railway が選択されました。');
        selectedRailwayCheckbox = true;
      }
    }
  }

// 駅チェックボックスture処理
  void _fetchStationList(String selectedRegionParam) {
    // region を selectedRegion に変更
    List<Map<String, dynamic>>? stations =
        stationList[selectedRegion]; // region を selectedRegion に変更
    if (stations != null) {
      print('駅リストが取得されました。');
      for (Map<String, dynamic> stationMap in stations) {
        String station = stationMap['value'];
        print('駅: $station が選択されました。');
        selectedStationCheckbox = true;
      }
    }
  }

  //リスト内のバックボタンのメソッド
  void handleBackButtonPressed() {
    setState(() {
      if (selectedStation != null && selectedStation!.isNotEmpty) {
        selectedStation = ''; // 駅を空に戻す
      } else if (selectedRailway != null && selectedRailway!.isNotEmpty) {
        selectedRailway = ''; // 沿線を空に戻す
      } else if (selectedPrefecture != null && selectedPrefecture!.isNotEmpty) {
        selectedPrefecture = ''; // 都道府県を空に戻す
      } else if (selectedRegion != null && selectedRegion!.isNotEmpty) {
        selectedRegion = ''; // 地域を空に戻す
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 選択された地域に応じて都道府県リストを取得
    // 表示するリストを決定
    List<String> displayList = regionsList; // デフォル
    if (displayList.contains(selectedRailway) ||
        displayList.contains(selectedStation)) {
      // チェックボックスの表示条件を確認し、条件に一致する場合はフラグを更新する
      showCheckboxes = true; // チェックボックスを表示する
    }

    if (selectedRegion != null && selectedRegion!.isNotEmpty) {
      List<Map<String, dynamic>>? selectedPrefectureList =
          prefectureList[selectedRegion!];
      if (selectedPrefectureList != null) {
        // 都道府県リストが見つかった場合の処理
        // selectedPrefectureList の各要素を String 型に変換して displayList に代入
        displayList = selectedPrefectureList
            .map((prefecture) => prefecture['value'].toString())
            .toList();
      } else {
        displayList = [];
      }
    }

    if (selectedPrefecture != null && selectedPrefecture!.isNotEmpty) {
      List<Map<String, dynamic>>? selectedRailwayList =
          railwayList[selectedPrefecture!];
      if (selectedRailwayList != null) {
        // 沿線リストが見つかった場合の処理
        // selectedRailwayList の各要素を String 型に変換して displayList に代入
        displayList = selectedRailwayList
            .map((railway) => railway['value'].toString())
            .toList();
      } else {
        displayList = [];
      }
    }

    if (selectedStation != null && selectedStation!.isNotEmpty) {
      List<Map<String, dynamic>>? selectedstationList =
          stationList[selectedRailway!];
      if (selectedstationList != null) {
        // 沿線リストが見つかった場合の処理
        // selectedRailwayList の各要素を String 型に変換して displayList に代入
        displayList = selectedstationList
            .map((Station) => Station['value'].toString())
            .toList();
      } else {
        displayList = [];
      }
    }
    // print('displayList$displayList'); // 追加したprint文

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: handleBackButtonPressed, // 戻るボタンが押されたときの処理を追加
                icon: Icon(Icons.arrow_back), // 戻るアイコンを指定します

                tooltip: '戻る', // ツールチップを設定します
              ),
              Text('1つ前に戻る'),
            ],
          ),
          ListView.builder(
            shrinkWrap: true, // ListViewの高さをコンテンツに合わせて制限します
            physics: NeverScrollableScrollPhysics(), // ListViewのスクロールを無効にします
            itemCount: displayList.length,
            itemBuilder: (BuildContext context, int index) {
              String region = displayList[index];

              String? selectedrRailwayApiKeyword = selectedStation;
              if (selectedRailway != null && selectedRailway!.isNotEmpty) {
                selectedrRailwayApiKeyword = selectedRailway![0];
              }

              String? selectedStationApiKeyword = selectedRailway;
              if (selectedStation != null && selectedStation!.isNotEmpty) {
                selectedStationApiKeyword = selectedStation![0]; // 最初の要素を選択
              }

              bool selectedRailwayCheckbox = region == selectedRailway;
              print(selectedRailway);
              bool selectedStationCheckbox = region == selectedStation;
              print(selectedStation);

              return ListTile(
                title: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // リストのタップ時の処理
                          if (selectedRegion == null ||
                              selectedRegion!.isEmpty) {
                            selectedRegion = displayList[index];
                            selectedPrefecture = '';
                            selectedRailway = '';
                            selectedStation = '';
                          } else if (selectedPrefecture == null ||
                              selectedPrefecture!.isEmpty) {
                            selectedPrefecture = displayList[index];
                            selectedRailway = '';
                            selectedStation = '';
                          } else if (selectedRailway == null ||
                              selectedRailway!.isEmpty) {
                            selectedRailway = displayList[index];
                            selectedStation = '';
                          } else {
                            selectedStation = displayList[index];
                          }
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 24),
                          Expanded(
                            child: Text(
                              '${displayList[index]} (2889)', //TODO件数でたら入れる
                              textAlign: TextAlign.start,
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: displayList.contains(selectedRailway)
                            // 沿線リストが表示されている場合チェックボックスを表示する

                            ? Checkbox(
                                //沿線のチェックボックスを使用するバリューを沿線チェックボックスにしている
                                value: selectedRailwayCheckbox,
                                onChanged: (bool? value) {
                                  handlerailwayCheckboxTap(
                                    value,
                                    region, // 正しい引数として railway を渡します
                                  );
                                },
                                checkColor: selectedRailwayCheckbox
                                    ? Colors.black
                                    : Colors.blue, // チェックマークの色を反映させます
                              )
                            : displayList.contains(
                                    selectedStation) // ステーションリストが表示されている場合チェックボックスを表示する
                                ? Checkbox(
                                    //駅のチェックボックスを使用するvalueを駅リストにしている
                                    value: selectedStationCheckbox,
                                    onChanged: (bool? value) {
                                      //TODOここのメソッドを追加するhandleStationCheckboxTap
                                      handleStationCheckboxTap(
                                        value,
                                        region, // 正しい引数として station を渡します
                                      );
                                    },
                                    checkColor: selectedStationCheckbox
                                        ? Colors.black
                                        : Colors.blue, // チェックマークの色を反映させます
                                  )
                                : SizedBox(), // その他の場合は何も表示しません
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//条件のクラス
//TODO他の場所で使える条件に変更する
class ConditionTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ConditionTabのインスタンスを取得
    ConditionTab conditionTab = ConditionTab();
    // 条件リストを取得
    List<String> conditions = conditionTab.conditionsList;
    return ListView.builder(
      itemCount: conditions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(conditions[index]),
          // ここに条件を選択するためのUI要素を配置する
        );
      },
    );
  }
}

//ボタン

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ボタンが押されたときの処理
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: Size(250, 60),
      ),
      child: Text(
        '検索',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
