import 'package:bade_wangsul/src/routes/routes.dart';
import 'package:bade_wangsul/src/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'modules/auth/login/login_screen.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bade Wangsul',
      getPages: routes,
      theme: myTheme,
      home: LoginScreen(),
    );
  }
}