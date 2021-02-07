import 'package:bade_wangsul/src/modules/modules.dart';
import 'package:bade_wangsul/src/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/register', page: () => RegisterScreen()),
  GetPage(name: '/forgot', page: () => ForgotPasswordScreen()),
];

const splashScreen = '/';
const loginScreen = '/login';
const registerScreen = '/register';
const forgotScreen = '/forgot';

  