import 'package:flutter/material.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timelineViewModel.dart';

class TimelineCard extends StatefulWidget {
  final TimelineItem item; //TimelineItem オブジェクトを受け取る

  const TimelineCard({
    Key? key, // key パラメータを追加
    required this.item,
  }) : super(key: key);

  @override
  _TimelineCardState createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  @override
  Widget build(BuildContext context) {
    print('ショップネーム: ${widget.item.shopName}');

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
