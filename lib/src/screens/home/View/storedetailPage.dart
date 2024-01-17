import 'package:flutter/material.dart';

class StoreDetailPage extends StatefulWidget {
  const StoreDetailPage({super.key});

  @override
  State<StoreDetailPage> createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('店舗の詳細'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('店舗名: Example Store'),
            Text('住所: 〇〇市〇〇区〇〇町1-2-3'),
            // 他にも店舗の詳細情報を表示するためのウィジェットを配置
          ],
        ),
      ),
    );
  }
}
