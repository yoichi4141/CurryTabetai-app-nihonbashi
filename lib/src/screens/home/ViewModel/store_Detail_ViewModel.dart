import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/Util/API/Service/shopservice.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/make_post_viewmodel.dart';
import 'package:flutter/material.dart';

class StoreDetailViewmodel extends ChangeNotifier {
  final ShopService shopService = ShopService();
  late final FirebaseFirestore _firestore;

  Future<void> saveShopToFirestore(String shopId, int postNumber) async {
    try {
      ShopData shopData = ShopData(
        shopId: shopId,
        postNumber: postNumber.toString(), // postNumberを文字列に変換
        shopLike: false.toString(), // shopNiceの初期値をfalseに設定
        shopWant: false.toString(), // shopWantの初期値をfalseに設定
      );
      await shopService.addShop(shopData);
    } catch (error) {
      print('Error saving shop data to Firestore: $error');
      throw error;
    }
  }

  //いいねのアップロード
  Future<void> addLikeToShopFire(String shopId, String userId) async {
    try {
      final db = FirebaseFirestore.instance;
      final doc = db.collection('shops').doc(shopId);

      // ドキュメントの likes フィールドが配列かどうか確認します
      final docSnapshot = await doc.get();
      if (docSnapshot.exists) {
        final shopData = docSnapshot.data();
        if (shopData != null) {
          List<dynamic> shopNiceList = [];
          if (shopData.containsKey('shopNice')) {
            // shopNiceフィールドが存在する場合、その値を取得します
            shopNiceList = shopData['shopNice'] as List;
          }
          if (shopNiceList.contains(userId)) {
            //すでにいいねがされている場合はたっぷして消えるのでarrayRemove
            await doc.update({
              'shopNice': FieldValue.arrayRemove([userId])
            });
          } else {
            //値がない場合はいいね色つけるので追加
            await doc.update({
              'shopNice': FieldValue.arrayUnion([userId])
            });
          }
        } else {
          // フィールドが配列でない場合、エラーを出力します
          print('Error: shopNice field is not an array');
        }
      } else {
        // ドキュメントが存在しない場合、エラーを出力します
        print('Error: Document does not exist');
      }
    } catch (error) {
      print('Error adding like to shop: $error');
      throw error;
    }
  }

  Future<int> getLikeCount(String shopId) async {
    try {
      print('Fetching like count for shopId: $shopId'); // shopId をプリント

      // Firestore から指定された店舗のドキュメントを取得
      final documentSnapshot =
          await _firestore.collection('shops').doc(shopId).get();
      // 取得したドキュメントから 'shopNice' フィールドの配列を取得
      final shopNiceArray = documentSnapshot.get('shopNice');
      // 配列の長さを返す
      return (shopNiceArray as List<dynamic>).length;
    } catch (e) {
      print('Error getting like count: $e');
      // エラー時はゼロを返すなど、適切なエラー処理を行う
      return 0;
    }
  }

  Future<bool> isShopNice(String shopId, String userId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('shops')
          .doc(shopId)
          .get();
      if (docSnapshot.exists) {
        final shopData = docSnapshot.data();
        if (shopData != null && shopData['shopNice'] is List) {
          final shopNiceList = shopData['shopNice'] as List;
          print('Shop Nice List: $shopNiceList'); // 追加したprint文
          return shopNiceList.length >= 2; // リストの要素数が2つ以上ならtrueを返す
        }
      }
      return false;
    } catch (error) {
      print('Error checking if shop is nice: $error');
      return false;
    }
  }
}
