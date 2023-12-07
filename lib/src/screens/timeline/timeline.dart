import 'package:flutter/material.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timelineViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/component/timelineCardState.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // timelineViewModelインスタンス
    final timelineViewModel = TimelineViewModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('タイムライン'),
      ),
      body: ListView.builder(
        itemCount: timelineViewModel.timelineList.length,
        itemBuilder: (BuildContext context, int index) {
          return TimelineCard(
            item: timelineViewModel.timelineList[index],
            image: timelineViewModel.timelineList[index].image,
            // ... other parameters
          );
        },
      ),
    );
  }
}
