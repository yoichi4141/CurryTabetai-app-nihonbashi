import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _requestLocationPermission(); // 位置情報の許可をリクエスト
  runApp(MyApp());
}

Future<void> _requestLocationPermission() async {
  await Geolocator.requestPermission();
}
