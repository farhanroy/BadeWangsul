import 'package:bade_wangsul/src/models/models.dart';
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

  Future<void> createPembina(Pembina pembina) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
          "name": pembina.name,
          "address": pembina.address,
          "age": pembina.age,
          "dormitory": pembina.dormitory,
          "phone_number": pembina.phoneNumber,
          "image_url": pembina.imageUrl,
          "usertype": "pembina"
        });
  }

  Future<void> createPengasuh(Pengasuh pengasuh) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
      "name": pengasuh.name,
      "address": pengasuh.address,
      "age": pengasuh.age,
      "dormitory": pengasuh.dormitory,
      "phone_number": pengasuh.phoneNumber,
      "image_url": pengasuh.imageUrl,
      "usertype": "pengasuh"
    });
  }

  Future<void> createSecurity(Security security) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
      "name": security.name,
      "address": security.address,
      "age": security.age,
      "pos": security.pos,
      "phone_number": security.phoneNumber,
      "image_url": security.imageUrl,
      "usertype": "security"
    });
  }

  Future<void> createKemanan(Keamanan keamanan) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
      "name": keamanan.name,
      "address": keamanan.address,
      "age": keamanan.age,
      "phone_number": keamanan.phoneNumber,
      "image_url": keamanan.imageUrl,
      "usertype": "keamanan"
    });
  }

  Future<void> createOrangtua(Orangtua orangtua) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
      "id_santri": orangtua.idSantri,
      "name": orangtua.name,
      "address": orangtua.address,
      "age": orangtua.age,
      "image_url": orangtua.imageUrl,
      "phone_number": orangtua.phoneNumber,
      "usertype": "orangtua"
    });
  }
}