import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  
  Future<String> getUsertype() async {
    var user = FirebaseAuth.instance.currentUser;
    var usertype = (await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION)
        .doc(user.uid)
        .get()).data()["usertype"].toString();
    print("Usertype = $usertype");
    return usertype;
  }

  Future<void> setUserData({String username, String usertype}) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
          "name": username,
          "address": "",
          "age": "",
          "dormitory": "",
          "image_url": "",
          "usertype": usertype
        });
  }
}