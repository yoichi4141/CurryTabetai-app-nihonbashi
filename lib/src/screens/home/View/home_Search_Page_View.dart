//ホーム画面から遷移する検索機能
import 'package:currytabetaiappnihonbashi/src/screens/home/View/home_Search_Filltersearch_View.dart';
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
  String? selectedStationApiKeyword;

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
      bottomNavigationBar: Footer(
        selectedStationApiKeyword: selectedStationApiKeyword,
        onTap: (value) {
          print('selectedStationApiKeyword: $selectedStationApiKeyword');

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeCurryFillterSearch(
                  value: value, // ここでパラメータ名と値を指定します
                  searchKeyword: selectedStationApiKeyword),
            ),
          );
        },
      ),
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
  String? selectedListtapStation;

  bool? selectedStationCheckbox; // selectedStationCheckboxの初期値をここで設定
  bool showCheckboxes = false; // チェックボックスの表示状態を管理するフラグ

  @override
  void initState() {
    super.initState();
    selectedRegion = '';
    selectedPrefecture = '';
    selectedRailway = '';
    selectedStation = '';
    selectedListtapStation = '';
    selectedStationCheckbox = false;
  }

  List<String> regionsList = SearchTab.regionsList;
  Map<String, List<Map<String, dynamic>>> prefectureList =
      SearchTab.prefectureList;
  Map<String, List<Map<String, dynamic>>> railwayList = SearchTab.railwayList;
  Map<String, List<Map<String, dynamic>>> stationList = SearchTab.stationList;

//チェックボックスをタップした時に実行されるメソッド
  void handleStationCheckboxTap(bool? checked, String selectedRegionParam) {
    _HomeCurrySearchViewState? state =
        context.findAncestorStateOfType<_HomeCurrySearchViewState>();
    if (state != null) {
      state.setState(() {
        selectedStation = selectedRegionParam;
        //TODO selectedListtapStationは、selectedStationと同様のリストの内容を格納するべきです
        state.selectedStationApiKeyword = selectedStation;

        print('ボックスの$selectedStation');
      });
    }
  }

//リストをタップした時に実行されるメソッド
  void handleListTap(String selectedItem) {
    _HomeCurrySearchViewState? state =
        context.findAncestorStateOfType<_HomeCurrySearchViewState>();
    if (state != null) {
      state.setState(() {
        selectedStation = selectedItem;
        state.selectedStationApiKeyword = selectedStation;
        print('リストの$selectedStation');
      });
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
        displayList.contains(selectedStation)) {}

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

              bool selectedStationCheckbox = region == selectedStation;
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
                          } else if (selectedPrefecture == null ||
                              selectedPrefecture!.isEmpty) {
                            selectedPrefecture = displayList[index];
                          } else if (selectedRailway == null ||
                              selectedRailway!.isEmpty) {
                            selectedRailway = displayList[index];
                          } else {
                            selectedStation = displayList[index];
                            handleListTap(displayList[index]);
                          }

                          selectedStationCheckbox = region == selectedStation;
                          selectedListtapStation = region;
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
                        child: displayList.contains(
                                selectedStation) // ステーションリストが表示されている場合チェックボックスを表示する
                            ? Checkbox(
                                //駅のチェックボックスを使用するvalueを駅リストにしている
                                value: selectedStationCheckbox,
                                onChanged: (bool? value) {
                                  handleStationCheckboxTap(
                                    value,
                                    region, // 正しい引数として station を渡します
                                  );
                                },

                                checkColor: !selectedStationCheckbox
                                    ? Colors.black
                                    : Colors.transparent, // チェックマークの色を反映させます
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
  final String? selectedStationApiKeyword;
  final Function(String?) onTap; // コールバック関数

  const Footer({
    Key? key,
    required this.selectedStationApiKeyword,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //selectedStationApiKeywordが空の場合
    if (selectedStationApiKeyword == null ||
        selectedStationApiKeyword!.isEmpty) {
      return SizedBox(); // 空のSizedBoxを返して非表示にする
    }
    return ElevatedButton(
      onPressed: () {
        onTap(selectedStationApiKeyword); // コールバック関数を呼び出して値を渡す
        print('コールバックに渡すキーワード$selectedStationApiKeyword');
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
