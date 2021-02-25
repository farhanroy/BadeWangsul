
import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsertypeManager {

  static Future<void> set(String usertype) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(Constants.APP_NAME, usertype);
  }

  static Future<String> get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String usertype =  preferences.getString(Constants.APP_NAME);
    print(usertype);
    return usertype;
  }

  static Future<void> delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(Constants.APP_NAME);
  }
}