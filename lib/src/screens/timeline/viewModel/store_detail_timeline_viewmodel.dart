import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreDetailTimelineItem {
  final String userId;
  final String shopId;
  final String postText;
  final String postImage;
  final String userName;
  final String profileImage;
  final String shopName;

  StoreDetailTimelineItem({
    required this.userId,
    required this.shopId,
    required this.postText,
    required this.postImage,
    required this.userName,
    required this.profileImage,
    required this.shopName,
  });
}

class StoreDitailTimelineViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<StoreDetailTimelineItem>> getStoreDetailTimelineItem(
      String shopId, String userId) {
    print('指定されたショップID: $shopId'); // shopIdの値を出力する
    print('指定されたユーザーID: $userId'); // shopIdの値を出力する

    return _firestore
        .collection('posts')
        .where('shopId', isEqualTo: shopId) // 指定されたショップIDに関連する投稿のみを取得
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      List<StoreDetailTimelineItem> storeDetailTimelineItem = [];

      for (var doc in snapshot.docs) {
        // 投稿のデータを取得
        Map<String, dynamic>? postData = doc.data() as Map<String, dynamic>?;

        if (postData != null) {
          String userName =
              postData['userName'] ?? ''; //displayNameと間違えやすい気をつけて
          String profileImage = postData['profileImage'] ?? '';
          String postText = postData['postText'] ?? '';
          String postImage = postData['postImage'] ?? '';
          String shopName = postData['shopName'] ?? '';
          // TimelineItemに追加

          storeDetailTimelineItem.add(StoreDetailTimelineItem(
            userId: userId,
            shopId: shopId,
            postText: postText,
            userName: userName,
            postImage: postImage,
            profileImage: profileImage,
            shopName: shopName,
          ));
        }
      }

      return storeDetailTimelineItem;
    });
  }
}
