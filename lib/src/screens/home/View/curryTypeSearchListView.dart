import 'package:currytabetaiappnihonbashi/src/screens/home/View/FilterSearchView.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curryTypeSearchListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CurryTypeSearchListView extends StatefulWidget {
  final String curryType;

  const CurryTypeSearchListView({Key? key, required this.curryType})
      : super(key: key);

  @override
  _CurryTypeSearchListViewState createState() =>
      _CurryTypeSearchListViewState();
}

class _CurryTypeSearchListViewState extends State<CurryTypeSearchListView> {
  final viewModel = CurryTypeSearchListViewModel();
  late List<CurryTypeItem> curryTypeItemlist;
  String sortOrder = 'カリー多い順';

  @override
  void initState() {
    super.initState();
    curryTypeItemlist = viewModel.curryTypeItemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),

          // サーチバー
          Padding(
            padding: EdgeInsets.all(10.0),
            child: SearchBar(
              hintText: '行きたいカリーショップを入力',
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // フィルターとマップボタン
          Row(
            children: [
              const SizedBox(width: 20),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.tune),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FilterSearchView(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.maps_ugc),
                  onPressed: () {
                    // TODO: ソートボタンが押されたときの処理
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 件数
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.yellow[100],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('123件'),
                  TextButton(
                    onPressed: () {
                      // アクションシートを出す
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            title: Text('並び替え'),
                            actions: [
                              CupertinoActionSheetAction(
                                child: Text('評価が高い順'),
                                onPressed: () {
                                  setState(() {
                                    sortOrder = '評価が高い順';
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text('金額が高い順'),
                                onPressed: () {
                                  setState(() {
                                    sortOrder = '金額が高い順';
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                            cancelButton: CupertinoButton(
                              child: Text('閉じる'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.swap_vert),
                        Text(sortOrder),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // リスト
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: curryTypeItemlist.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                final CurryTypeItem item = curryTypeItemlist[index];

                return InkWell(
                    onTap: () {
                      // TODO: Cellタップ時の処理
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.min, // この行を追加
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.shopName,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            item.description,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          item.images[0]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Container(
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          item.images[1]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Container(
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          item.images[2]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(children: [
                                            Text(
                                              item.price,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              '営業時間: ${item.openingHours}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ]),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                '評価: ${item.valuation}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
