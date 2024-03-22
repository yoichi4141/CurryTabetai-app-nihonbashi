import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_Ditailtimeline_CardState.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/store_Detail_ViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/store_detail_timelineItem_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreDetailTimeline extends StatelessWidget {
  final String userId;
  final String shopId;
  final String shopName;
  const StoreDetailTimeline({
    Key? key,
    required this.userId,
    required this.shopId,
    required this.shopName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //StoreDetailViewmodelのインスタンス

    // timelineViewModelインスタンス
    final storeDitailTimelineViewModel =
        Provider.of<StoreDitailTimelineItemViewModel>(context, listen: false);
    final storeDetailViewmodel =
        Provider.of<StoreDetailViewmodel>(context, listen: false);

    // timelineViewModelインスタンス

    return Scaffold(
      body: StreamBuilder<List<StoreDetailTimelineItem>>(
        stream: storeDitailTimelineViewModel.getStoreDetailTimelineItem(
            shopId, userId),
        builder: (context, snapshot) {
          print('storeDatailのデータ: ${snapshot.data}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('エラーが発生しました: ${snapshot.error}');
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          }

          // データが空であるかどうかをチェック
          if (snapshot.data!.isEmpty) {
            return Center(child: Text('データがありません'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return StoreDitailTimelineCard(
                item: item,
                storeDetailViewmodel: storeDetailViewmodel,
              );
            },
          );
        },
      ),
    );
  }
}
