import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_Home_View.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Detail_timeline_view.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timeline_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timeline_Item_viewmodel.dart';

class TimelineCard extends StatefulWidget {
  final TimelineItem item; //TimelineItem オブジェクトを受け取る
  final TimeLineViewModel timeLineViewModel;
  const TimelineCard({
    Key? key, // key パラメータを追加
    required this.item,
    required this.timeLineViewModel,
  }) : super(key: key);

  @override
  _TimelineCardState createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  late Color iconColor;
  bool shopNice = false;

  @override
  void initState() {
    super.initState();
    iconColor = Colors.black;
  }

  Future<void> fetchShopNiceStatus() async {
    try {
      final isNice = await widget.timeLineViewModel
          .isShopNice(widget.item.shopId, widget.item.userId);
      setState(() {
        shopNice = isNice;
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
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return StoredetailHome(
              id: widget.item.shopId,
              name: widget.item.shopName,
            );
          }));
          print('userId: ${widget.item.shopId}');
          print('shopName: ${widget.item.shopName}');
        },
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
                        Text(
                          widget.item.userName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            widget.item.shopName,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
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
                              : null, // デフォルト表示用のアイコンやウィジェット
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     IconButton(
                        //       onPressed: () async {
                        //         setState(() {
                        //           shopNice = !shopNice;
                        //           iconColor =
                        //               shopNice ? Colors.red : Colors.black;
                        //         });

                        //         try {
                        //           await widget.timeLineViewModel
                        //               .addLikeToShopFire(
                        //             widget.item.shopId,
                        //             widget.item.userId,
                        //           );
                        //         } catch (error) {
                        //           print('Error adding like to shop: $error');
                        //         }
                        //       },
                        //       icon: Icon(
                        //         shopNice
                        //             ? Icons.favorite
                        //             : Icons.favorite_border,
                        //         color: iconColor,
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
