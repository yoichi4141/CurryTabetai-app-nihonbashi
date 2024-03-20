import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/make_post_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TimelineItem {
  final String userId;
  final String shopId;
  final String postText;
  final String postImage;
  final String userName;
  final String profileImage;
  final String shopName;

  TimelineItem({
    required this.userId,
    required this.shopId,
    required this.postText,
    required this.postImage,
    required this.userName,
    required this.profileImage,
    required this.shopName,
  });
}

class TimelineViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<TimelineItem>> getTimelineItems() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      List<TimelineItem> timelineItems = [];

      for (var doc in snapshot.docs) {
        // 投稿のデータを取得
        Map<String, dynamic>? postData = doc.data();

        if (postData != null) {
          String userId = postData['userId'];

          // ユーザーのドキュメントを取得
          DocumentSnapshot userDoc =
              await _firestore.collection('users').doc(userId).get();
          if (userDoc.exists) {
            Map<String, dynamic>? userData =
                userDoc.data() as Map<String, dynamic>?;
            if (userData != null) {
              String userName = userData['displayName'] ?? '匿名ユーザー';
              String profileImage = userData['profileImage'] ?? '';
              String postText = postData['postText'] ?? '';
              String postImage = postData['postImage'] ?? '';
              String shopName = postData['shopName'] ?? '';

              // TimelineItemに追加
              timelineItems.add(TimelineItem(
                userId: userId,
                //TODOここのshopId
                shopId: '',
                postText: postText,
                userName: userName,
                postImage: postImage,
                profileImage: profileImage,
                shopName: shopName,
              ));
            }
          }
        }
      }

      return timelineItems;
    });
  }
}
