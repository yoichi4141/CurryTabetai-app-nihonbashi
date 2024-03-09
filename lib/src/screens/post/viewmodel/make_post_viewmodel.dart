import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MakePostViewModel with ChangeNotifier {
  List<File> images = [];

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
}
