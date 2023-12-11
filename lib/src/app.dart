import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'screens/post/post.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
