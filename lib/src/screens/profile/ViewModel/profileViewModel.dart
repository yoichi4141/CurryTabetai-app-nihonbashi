import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/Util/API/Model_Fierbase/firebaseResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileViewModel with ChangeNotifier {
  UserModel? userModel;

  ProfileViewModel() {
    fetchUserData();
    print('ProfileViewModelUserModel: $userModel');
  }

  Future<void> fetchUserData() async {
    // ここでユーザーIDを指定する必要があります

    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userData = snapshot.data();
    if (userData != null) {
      userModel = UserModel(
        userId: snapshot.id,
        email: userData['email'] ?? '',
        displayName: userData['displayName'] ?? '',
        profileImage: userData['profileImage'] ?? '',
        introduction: userData['introduction'] ?? '',
        favoriteCurry: userData['favoriteCurry'] ?? '',
      );
      notifyListeners();
    }
  }
}
