import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/Util/API/Service/shopservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Post {
  Post({
    required this.shopId,
    required this.postText,
    required this.createdAt,
    required this.userId,
    required this.postImage,
    required this.userName,
    required this.profileImage,
    required this.shopName,
  });

  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Post(
      shopId: map['shopId'],
      postText: map['postText'],
      createdAt: map['createdAt'],
      userId: map['userId'],
      postImage: map['postImage'],
      userName: map['userName'],
      profileImage: map['profileImage'],
      shopName: map['shopName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'postText': postText,
      'createdAt': createdAt,
      'userId': userId,
      'postImage': postImage,
      'userName': userName,
      'profileImage': profileImage,
      'shopName': shopName,
    };
  }

  final String shopId;
  final String postText;
  final Timestamp createdAt;
  final String userId;
  final String postImage;
  final String userName;
  final String profileImage;
  final String shopName;
}

class Shop {
  Shop({
    required this.postNumber,
    required this.shopNice,
    required this.shopWant,
  });

  factory Shop.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return Shop(
      postNumber: map['postNumber'],
      shopNice: List<String>.from(map['shopNice']), // 配列として取得
      shopWant: map['shopWant'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postNumber': postNumber,
      'shopNice': shopNice,
      'shopWant': shopWant,
    };
  }

  final String postNumber;
  final List<String> shopNice; // 配列として定義
  final String shopWant;
}

String shopId = shopId;

class MakePostViewModel with ChangeNotifier {
  late final ShopService shopService;
  //postsReferenceをグローバル変数として定義
  final postsReference =
      FirebaseFirestore.instance.collection('posts').withConverter<Post>(
    fromFirestore: ((snapshot, _) {
      return Post.fromFirestore(snapshot);
    }),
    toFirestore: ((value, _) {
      return value.toMap();
    }),
  );

  List<File> images = [];
  DateTime selectedDate = DateTime.now();

// 画像をギャラリーから選んでリストにする関数
  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // 画像がnullの場合戻る
      if (image == null) return;

      final imageFile = File(image.path);
      images.add(imageFile);

      // 画像が選択されたことを通知するために、リスナーに変更を通知
      notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

//選択したイメージを Firebaseにアップロードする
  Future<String> uploadImage(File imageFile) async {
    String filePath =
        'uploads/${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(filePath);

    firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);

    // アップロードが完了するのを待ちます
    await uploadTask.whenComplete(() => null);
    // アップロードした画像のURLを取得します
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

//イメージをデリートする※アイコンのデリートボタンから
  void deleteImage(int index) {
    //indexが０以上かつimages リストの長さ未満であることを確認している
    if (index >= 0 && index < images.length) {
      //imagesリストから指定されたindexの要素を削除する
      images.removeAt(index);
      notifyListeners();
    }
  }

  //カレンダーから日付を取得する
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        // カスタムウィジェット内で影を除去する
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: Colors.green,
            ),
            // カレンダーの背景色を設定
            dialogBackgroundColor: Colors.green,
          ),
          child: ExcludeSemantics(
            child: child, // カレンダーウィジェットを表示
          ),
        );
      },
    );

    if (picked != null) {
      selectedDate = picked;
    }
  }

//boolを返す形に変更
  Future<bool> createPost(String text, String id, String name) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userId = user.uid;
      final shopId = id;
      String imageUrl = '';
      final shopName = name;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final userName = userData['displayName'] ?? '匿名ユーザー';
        final profileImage = userData['profileImage'] ?? '';

        if (images.isNotEmpty) {
          imageUrl = await uploadImage(images.first);
        }
        //普通にselectedDate使うとDataTIme型のエラー出るので Firebaseが受け取れる形に変換（ FirebaseはTimestampとして日時を欲しがる）
        final createdAtTimestamp = Timestamp.fromDate(selectedDate);

        final postNumber = '';
        final shopNice = '';
        final shopWant = '';

        // 新しい投稿を作成
        final newPost = Post(
          createdAt: createdAtTimestamp,
          shopId: shopId,
          userId: userId,
          postText: text,
          postImage: imageUrl,
          userName: userName, // ユーザー名を追加
          profileImage: profileImage, // プロフィール画像を追加
          shopName: shopName,
        );

        final newshop = Shop(
          postNumber: postNumber,
          shopNice: [userId],
          shopWant: shopWant,
        );

        // Firestoreのpostsコレクションに新しい投稿を追加
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(shopId) // 店舗ごとのドキュメント
            .collection(userId) // ユーザーコレクション
            .add(newPost.toMap()); // Firestoreが自動的に一意のドキュメントIDを生成

        await FirebaseFirestore.instance
            .collection('shops')
            .doc(shopId)
            .set(newshop.toMap());

        //投稿作成が成功したことを返す
        return true;
      }
    } catch (e) {
      print('投稿の作成に失敗しました: $e');
    }
    //投稿の作成が失敗したことを返す
    return false;
  }

  notifyListeners();
}
