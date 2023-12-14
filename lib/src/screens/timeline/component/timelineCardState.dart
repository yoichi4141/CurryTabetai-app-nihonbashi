import 'package:flutter/material.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timelineViewModel.dart';

class TimelineCard extends StatefulWidget {
  final TimelineItem item;
  final String image; // ここに画像を追加

  const TimelineCard({super.key, 
    required this.item,
    required this.image, // コンストラクターに画像を追加
    // ... other parameters
  });

  @override
  _TimelineCardState createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  bool favorite = false;
  bool retweeted = false;

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
                  const CircleAvatar(
                      // Display user avatar or default avatar
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
                            widget.item.text,
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
                            image: widget.item.image != null
                                ? DecorationImage(
                                    image: NetworkImage(widget.item.image),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: widget.item.image == null
                              ? const Icon(Icons.add)
                              : null, // デフォルト表示用のアイコンやウィジェット
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
