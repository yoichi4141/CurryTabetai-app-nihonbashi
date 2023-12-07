import 'package:flutter/material.dart';

class TimelineItem {
  final String text;
  final String image;
  final String userName;

  TimelineItem({
    required this.text,
    required this.image,
    required this.userName,
  });
}

class TimelineViewModel with ChangeNotifier {
  // 本来はFirebaseから取得
  List<TimelineItem> timelineList = [
    TimelineItem(
      text:
          '私は〜カリーマスターハァァぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁぁあぁぁぁぁぁぁぁぁぁぁぁぁぁぁああああああああああああ',
      image: 'https://pbs.twimg.com/media/EOr_CaDUUAATxPL.jpg:thumb',
      userName: 'クマール',
    ),
    TimelineItem(
      text: 'カリー',
      image: 'https://pbs.twimg.com/media/EOr_CaDUUAATxPL.jpg:thumb',
      userName: 'クマール',
    ),
    TimelineItem(
      text: 'カリー',
      image: 'https://pbs.twimg.com/media/EOr_CaDUUAATxPL.jpg:thumb',
      userName: 'クマール',
    ),
    TimelineItem(
      text: 'カリー',
      image: 'https://pbs.twimg.com/media/EOr_CaDUUAATxPL.jpg:thumb',
      userName: 'クマール',
    ),
  ];
}
