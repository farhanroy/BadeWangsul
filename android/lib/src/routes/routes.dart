import 'package:bade_wangsul/src/modules/splash/splash_screen.dart';
import 'package:bade_wangsul/src/modules/auth/screens/login_screen.dart';
import 'package:bade_wangsul/src/modules/auth/screens/register_screen.dart';
import 'package:bade_wangsul/src/modules/auth/screens/forgot_password_screen.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/register', page: () => RegisterScreen()),
  GetPage(name: '/forgot', page: () => ForgotPasswordScreen()),
];