import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/make_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timelineViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/component/timelineCardState.dart';
import 'package:provider/provider.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // timelineViewModelインスタンス
    final timelineviewModel =
        Provider.of<TimelineViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('みんなのカリーログ'),
      ),
      body: StreamBuilder<List<TimelineItem>>(
        stream: timelineviewModel.getTimelineItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('データがありません'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return TimelineCard(
                item: item,
              );
            },
          );
        },
      ),
    );
  }
}
