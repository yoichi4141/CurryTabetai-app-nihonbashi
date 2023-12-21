import 'package:flutter/material.dart';

class FilterSearchView extends StatefulWidget {
  const FilterSearchView({Key? key}) : super(key: key);

  @override
  _FilterSearchViewState createState() => _FilterSearchViewState();
}

class _FilterSearchViewState extends State<FilterSearchView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('絞り込み検索'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // TODO: クローズボタンが押されたときの処理
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  // TODO: クリアボタンが押されたときの処理
                },
                child: Text('クリア'))
          ],
        ),
        // TODO: 中身は要素が決まってから実装
        body: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}
