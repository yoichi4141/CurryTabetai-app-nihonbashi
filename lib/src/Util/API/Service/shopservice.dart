//shopサービスにする
//shopの色々

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopData {
  String postNumber;
  String shopId;
  String shopLike;
  String shopWant;

  ShopData({
    required this.postNumber,
    required this.shopId,
    required this.shopLike,
    required this.shopWant,
  });

  factory ShopData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return ShopData(
      shopId: map['shopId'],
      postNumber: map['postNumber'],
      shopLike: map['shopNice'],
      shopWant: map['shopWant'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postNumber': postNumber,
      'shopId': shopId,
      'shopLike': shopLike,
      'shopWant': shopWant,
    };
  }
}

//shopコレクションに格納各データを格納する
class ShopService extends ChangeNotifier {
  final CollectionReference shopCollection =
      FirebaseFirestore.instance.collection('shops');

  Future<void> addShop(ShopData shopData) async {
    try {
      await shopCollection.doc(shopData.shopId).set(shopData.toMap());
    } catch (error) {
      print('Error adding shop data: $error');
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
        if (shopData != null && shopData['shopNice'] is List) {
          // 配列にいいねを追加または削除します
          final shopNiceList = shopData['shopNice'] as List;
          if (shopNiceList.contains(userId)) {
            await doc.update({
              'shopNice': FieldValue.arrayRemove([userId])
            });
          } else {
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

//いいねのアップデート
  Future<void> updateShopNiceFire(
      String shopId, String userId, bool shopNice) async {
    try {
      // Firestoreにいいね情報を更新
      await FirebaseFirestore.instance
          .collection('shops')
          .doc(shopId)
          .update({'shopNice.$userId': shopNice});
    } catch (error) {
      print('Error updating like status: $error');
      throw error;
    }
  }

  Future<int> countLikes(String shopId) async {
    try {
      print('aaa: $shopId'); // shopId の値をプリント

      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection('shops')
              .doc(shopId)
              .get();
      if (docSnapshot.exists) {
        final Map<String, dynamic>? data = docSnapshot.data();

        if (data != null) {
          final List<dynamic> shopNiceList = data['shopNice'];
          // shopNiceList の要素数が2の場合は1、それ以外は0を返す
          return shopNiceList.length == 2 ? 1 : 0;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (error) {
      print('Error counting likes:$error');
      throw error;
    }
  }
}
