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
class ShopService {
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

//いきたいねのアップロード
  Future<void> addWantToShopFire(String shopId, String userId) async {
    try {
      // Firestoreにいいね情報を保存
      await FirebaseFirestore.instance
          .collection('shops')
          .doc(shopId)
          .update({'shopNice.$userId': true});
    } catch (error) {
      print('Error adding like to shop: $error');
      throw error;
    }
  }

//いきたいねのアップデート
  Future<void> updateWantToShopFire(
      String shopId, String userId, bool shopWant) async {
    try {
      // Firestoreにいいね情報を更新
      await FirebaseFirestore.instance
          .collection('shops')
          .doc(shopId)
          .update({'shopWant.$userId': shopWant});
    } catch (error) {
      print('Error updating like status: $error');
      throw error;
    }
  }
}
