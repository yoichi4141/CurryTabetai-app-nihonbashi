import 'package:flutter/material.dart';

class CurryTypeItem {
  final String shopName;
  final String description;
  final List<String> images;
  final String price;
  final String openingHours;
  final int valuation;

  CurryTypeItem({
    required this.shopName,
    required this.description,
    required this.images,
    required this.price,
    required this.openingHours,
    required this.valuation,
  });
}

class CurryTypeSearchListViewModel with ChangeNotifier {
  // 本来はFirebaseから取得
  List<CurryTypeItem> curryTypeItemList = [
    CurryTypeItem(
        shopName: 'Vashon',
        description: 'インドレストラン',
        images: [
          'https://tblg.k-img.com/restaurant/images/Rvw/147348/640x640_rect_147348936.jpg',
          'https://tblg.k-img.com/restaurant/images/Rvw/144005/640x640_rect_144005346.jpg',
          'https://tblg.k-img.com/restaurant/images/Rvw/139321/640x640_rect_139321258.jpg'
        ],
        price: '1000円〜',
        openingHours: ' 10:00 - 21:00',
        valuation: 5),
    CurryTypeItem(
        shopName: 'Vashon',
        description: 'インドレストラン',
        images: [
          'https://tblg.k-img.com/restaurant/images/Rvw/147348/640x640_rect_147348936.jpg',
          'https://tblg.k-img.com/restaurant/images/Rvw/144005/640x640_rect_144005346.jpg',
          'https://tblg.k-img.com/restaurant/images/Rvw/139321/640x640_rect_139321258.jpg'
        ],
        price: '1000円〜',
        openingHours: ' 10:00 - 21:00',
        valuation: 5),
    CurryTypeItem(
        shopName: 'Vashon',
        description: 'インドレストラン',
        images: [
          'https://tblg.k-img.com/restaurant/images/Rvw/147348/640x640_rect_147348936.jpg',
          'https://tblg.k-img.com/restaurant/images/Rvw/144005/640x640_rect_144005346.jpg',
          'https://tblg.k-img.com/restaurant/images/Rvw/139321/640x640_rect_139321258.jpg'
        ],
        price: '1000円〜',
        openingHours: ' 10:00 - 21:00',
        valuation: 5),
  ];
}
