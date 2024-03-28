import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/store_Detail_ShopPage_Google_Viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/home_Search_Page_Listdete_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map_NearshopAPI_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/curry_Map_Placeresult_ViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/store_Detail_ViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/home/ViewModel/store_Details_HotpepperViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/make_post_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/postviewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/profile/ViewModel/profileViewModel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/signup_login/ViewModel/login_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/signup_login/ViewModel/signup_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/store_detail_timelineItem_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timeline_Item_viewmodel.dart';
import 'package:currytabetaiappnihonbashi/src/screens/timeline/viewModel/timeline_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home/View/home.dart';
import 'screens/home/ViewModel/curry_Map_LocationAPI_ViewModel.dart';
import 'screens/post/view/post.dart';
import 'screens/profile/profile.dart';
import 'screens/timeline/timeline.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 他の必要なプロバイダーをここに追加できます
        ChangeNotifierProvider(create: (_) => StoreDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => MapViewModel()),
        ChangeNotifierProvider(
            create: (context) => GoogleStoreDetailViewModel()),
        ChangeNotifierProvider(
          create: (context) => LocationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaceResultViewModel(),
        ),
        ChangeNotifierProvider(create: (_) => ConditionTab()),
        ChangeNotifierProvider(create: (_) => SearchTab()),
        ChangeNotifierProvider(
            create: (_) => SignUpViewModel()), // SignUpViewModelを提供
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
        ChangeNotifierProvider(create: (_) => MakePostViewModel()),
        ChangeNotifierProvider(create: (_) => TimelineItemViewModel()),
        ChangeNotifierProvider(create: (_) => StoreDetailViewmodel()),
        ChangeNotifierProvider(
            create: (_) => StoreDitailTimelineItemViewModel()),
        ChangeNotifierProvider(create: (_) => TimeLineViewModel()),
        ChangeNotifierProvider(create: (_) => LoginWithGooglViewModel()),
        ChangeNotifierProvider(create: (_) => LoginWithAppleViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey), // ヒントテキストのスタイルを設定
          ),
        ),
        home: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    TimelineScreen(),
    PostScreen(),
    ProfileScreen()
  ];

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
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
