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

class TimelineItemViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<TimelineItem>> getTimelineItems() {
    return _firestore
        .collection('timeline') // コレクションのパスを 'posts' から 'timeline' に変更
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        Map<String, dynamic> postData = document.data() as Map<String, dynamic>;
        String userId = postData['userId'] ?? '';
        String userName = postData['userName'] ?? '匿名ユーザー';
        String profileImage = postData['profileImage'] ?? '';
        String postText = postData['postText'] ?? '';
        String postImage = postData['postImage'] ?? '';
        String shopName = postData['shopName'] ?? '';
        String shopId = postData['shopId'] ?? '';

        return TimelineItem(
          userId: userId,
          shopId: shopId,
          postText: postText,
          userName: userName,
          postImage: postImage,
          profileImage: profileImage,
          shopName: shopName,
        );
      }).toList();
    });
  }
}
