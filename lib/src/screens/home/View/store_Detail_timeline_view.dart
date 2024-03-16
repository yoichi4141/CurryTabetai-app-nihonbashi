import 'package:currytabetaiappnihonbashi/src/screens/home/View/store_CardState.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/component/timelineCardState.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timelineViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreDetailTimeline extends StatelessWidget {
  final String shopId;
  final String shopName;
  const StoreDetailTimeline({
    Key? key,
    required this.shopId,
    required this.shopName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // timelineViewModelインスタンス
    final timelineViewModel =
        Provider.of<TimelineViewModel>(context, listen: false);

    return Scaffold(
      body: StreamBuilder<List<StoreTimelineItem>>(
        stream: timelineViewModel.getStoreDetailTimelineItem(shopId),
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
              return StoreTimelineCard(
                item: item,
              );
            },
          );
        },
      ),
    );
  }
}
