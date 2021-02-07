import 'package:bade_wangsul/src/modules/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initialize();
  runApp(App());
}

void initialize() {
  Get.lazyPut(() => AuthenticationController(Get.put(AuthenticationService())),);
}
