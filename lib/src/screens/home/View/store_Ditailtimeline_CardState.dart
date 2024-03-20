import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/store_Detail_ViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/make_post_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/store_detail_timeline_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timelineViewModel.dart';
import 'package:provider/provider.dart';

class StoreDitailTimelineCard extends StatefulWidget {
  final StoreDetailTimelineItem item; //TimelineItem オブジェクトを受け取る
  final StoreDetailViewmodel storeDetailViewmodel;

  const StoreDitailTimelineCard({
    Key? key, // key パラメータを追加
    required this.item,
    required this.storeDetailViewmodel,
  }) : super(key: key);

  @override
  _TimelineCardState createState() => _TimelineCardState();
}

class _TimelineCardState extends State<StoreDitailTimelineCard> {
  late Color iconColor;
  bool shopNice = false; // shopNice の初期化

  @override
  void initState() {
    super.initState();
    iconColor = Colors.black; // 初期値を設定

    fetchShopNiceStatus();
  }

  // shopNice の状態を取得するメソッド
  Future<void> fetchShopNiceStatus() async {
    try {
      final isNice = await widget.storeDetailViewmodel.isShopNice(
        widget.item.shopId,
        widget.item.userId,
      );
      setState(() {
        shopNice = isNice;
        // shopNice の状態に応じてアイコンの色を変更
        iconColor = shopNice ? Colors.red : Colors.black;
      });
    } catch (error) {
      print('Error fetching shop nice status: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.item.profileImage),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ユーザー名
                        Text(
                          widget.item.userName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // ショップ名
                        Text(
                          widget.item.shopName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // 投稿テキスト
                        SizedBox(
                          width: 300,
                          child: Text(
                            widget.item.postText,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8), // 余白を追加
                        // 投稿画像
                        Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            image: widget.item.postImage != null
                                ? DecorationImage(
                                    image: NetworkImage(widget.item.postImage),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: widget.item.postImage == null
                              ? const Icon(Icons.add)
                              : null,
                        ),
                        const SizedBox(height: 8), // 余白を追加
                        // いいねアイコン
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () async {
                                setState(() {
                                  shopNice = !shopNice;
                                  iconColor =
                                      shopNice ? Colors.red : Colors.black;
                                });

                                try {
                                  await widget.storeDetailViewmodel
                                      .addLikeToShopFire(
                                    widget.item.shopId,
                                    widget.item.userId,
                                  );
                                } catch (error) {
                                  print('Error adding like to shop: $error');
                                }
                              },
                              icon: Icon(
                                shopNice
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: iconColor,
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
      ),
    );
  }
}
