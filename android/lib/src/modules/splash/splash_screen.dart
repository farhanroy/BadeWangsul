import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _duration = new Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  _checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", true);
    bool isLoggedIn = prefs.getBool("isLoggedIn");
    if(isLoggedIn){
      new Timer(_duration, navigationPage("/register"));
    } else {
      new Timer(_duration, navigationPage("/login"));
    }

  }

  navigationPage(namedRoute) {
    Get.toNamed(namedRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Bade Wangsul"),
    );
  }
}
