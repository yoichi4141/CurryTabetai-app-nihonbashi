import 'package:currytabetaiappnihonbashi/src/screens/post/view/postsearch.dart';
import 'package:flutter/material.dart';
import 'screens/home/View/home.dart';
import 'screens/post/viewmodel.dart/post.dart';
import 'screens/profile/profile.dart';
import 'screens/timeline/timeline.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const _screens = [
    HomeScreen(),
    TimelineScreen(),
    PostScreen(),
    ProfileScreen()
  ];

  int _selectedIndex = 0;

//投稿画面bottomNavigationBarが選択された時の処理を変更しましたよ〜〜〜
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        // 投稿画面が選択された場合、SignedpostsearchView に遷移する
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SignedpostsearchView(),
              fullscreenDialog: true,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 10,
          unselectedFontSize: 10,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'タイムライン'),
            BottomNavigationBarItem(icon: Icon(Icons.feed), label: '投稿'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
