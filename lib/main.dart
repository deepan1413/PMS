import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pms/firebase_options.dart';
import 'package:pms/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
