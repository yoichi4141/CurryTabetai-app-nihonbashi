import 'package:currytabetaiappnihonbashi/src/Util/API/Model/hotpepperApiResponse.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/FilterSearchView.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curryTypeSearchListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CurryTypeSearchListView extends StatefulWidget {
  final String curryType;

  const CurryTypeSearchListView({Key? key, required this.curryType})
      : super(key: key);

  @override
  _CurryTypeSearchListViewState createState() =>
      _CurryTypeSearchListViewState();
}

class _CurryTypeSearchListViewState extends State<CurryTypeSearchListView> {
  late CurryTypeSearchListViewModel viewModel;

  String sortOrder = 'おすすめ順';

  @override
  void initState() {
    super.initState();
    viewModel = CurryTypeSearchListViewModel(widget.curryType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => viewModel,
            child: Consumer<CurryTypeSearchListViewModel>(
                builder: (context, viewModel, _) {
              return SafeArea(
                  child: GestureDetector(
                      onTap: () {
                        // キーボードを閉じる
                        FocusScope.of(context).unfocus();
                      },
                      child: Column(
                        children: [
                          // サーチバー
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SearchBar(
                              hintText: 'ショップを検索',
                              leading: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              onChanged: (value) {
                                viewModel.filterList(value);
                              },
                              onSubmitted: (value) {
                                FocusScope.of(context).unfocus();
                              },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${viewModel.response.results.shop.length}件'),
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
                                                child: Text('名前順'),
                                                onPressed: () {
                                                  viewModel.sortShopsByName(
                                                      viewModel.response.results
                                                          .shop);
                                                  setState(() {
                                                    sortOrder = '名前順';
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoActionSheetAction(
                                                child: Text('予算が安い順'),
                                                onPressed: () {
                                                  viewModel.sortShopsByPrice(
                                                      viewModel.response.results
                                                          .shop);
                                                  setState(() {
                                                    sortOrder = '予算が安い順';
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                            cancelButton: CupertinoButton(
                                              child: Text('閉じる'),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
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
                              // データ取得中はローディング表示
                              child: viewModel.isLoading
                                  ? const Center(
                                      child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 8.0)),
                                    )
                                  : ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemCount: viewModel
                                              .response?.results.shop.length ??
                                          0,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final Shop item = viewModel
                                            .response.results.shop[index];

                                        return InkWell(
                                            onTap: () {
                                              // TODO: 店舗詳細画面へ遷移
                                            },

                                            // エラーメッセージがあれば表示
                                            child:
                                                viewModel
                                                        .errorMessage.isNotEmpty
                                                    ? Text(
                                                        viewModel.errorMessage)
                                                    : Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      16.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            // 店舗名
                                                                            Text(
                                                                              item.name,
                                                                              style: const TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 2),

                                                                            // ジャンル
                                                                            Text(
                                                                              item.genre.name,
                                                                              style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 5),

                                                                            // 画像
                                                                            Row(children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  height: 200,
                                                                                  decoration: BoxDecoration(
                                                                                    image: DecorationImage(
                                                                                      image: NetworkImage(item.photo?.pc.l ?? ''),
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ]),

                                                                            const SizedBox(height: 5),

                                                                            // 営業時間
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    '営業時間: ${item.open}',
                                                                                    style: const TextStyle(
                                                                                      fontSize: 12,
                                                                                      color: Colors.grey,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),

                                                                            const SizedBox(height: 8),

                                                                            // 定休日
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    '定休日: ${item.close}',
                                                                                    style: const TextStyle(
                                                                                      fontSize: 12,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),

                                                                            const SizedBox(height: 8),

                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  '予算: ${item.budget.name}',
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
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
                                    )),
                        ],
                      )));
            })));
  }
}
