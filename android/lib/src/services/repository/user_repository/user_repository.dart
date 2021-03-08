import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../database/dao/users_dao.dart';
import '../../../models/models.dart';
import '../../../utils/constants.dart';

class UserRepository {
  final usersDao = UsersDao();
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
          "id":user.uid,
          "name": pembina.name,
          "address": pembina.address,
          "age": pembina.age,
          "dormitory": pembina.dormitory,
          "phoneNumber": pembina.phoneNumber,
          "imageUrl": pembina.imageUrl,
          "usertype": "pembina"
        });
  }

  Future<void> updatePembina(Pembina pembina) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .update({
      "id":user.uid,
      "name": pembina.name,
      "address": pembina.address,
      "age": pembina.age,
      "dormitory": pembina.dormitory,
      "phoneNumber": pembina.phoneNumber,
      "imageUrl": pembina.imageUrl,
      "usertype": "pembina"
    });

    await usersDao.updateOrInsertPembina();
  }

  Future<void> createPengasuh(Pengasuh pengasuh) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
      "name": pengasuh.name,
      "address": pengasuh.address,
      "age": pengasuh.age,
      "dormitory": pengasuh.dormitory,
      "phoneNumber": pengasuh.phoneNumber,
      "imageUrl": pengasuh.imageUrl,
      "usertype": "pengasuh"
    });
  }

  Future<void> updatePengasuh(Pengasuh pengasuh) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .update({
      "id":user.uid,
      "name": pengasuh.name,
      "address": pengasuh.address,
      "age": pengasuh.age,
      "dormitory": pengasuh.dormitory,
      "phoneNumber": pengasuh.phoneNumber,
      "imageUrl": pengasuh.imageUrl,
      "usertype": "pengasuh"
    });

    await usersDao.updateOrInsertPengasuh();
  }

  Future<void> createSecurity(Security security) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
      "id":user.uid,
      "name": security.name,
      "address": security.address,
      "age": security.age,
      "pos": security.pos,
      "phoneNumber": security.phoneNumber,
      "imageUrl": security.imageUrl,
      "usertype": "security"
    });

    await usersDao.updateOrInsertSecurity();
  }

  Future<void> updateSecurity(Security security) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .update({
      "id":user.uid,
      "name": security.name,
      "address": security.address,
      "age": security.age,
      "pos": security.pos,
      "phoneNumber": security.phoneNumber,
      "imageUrl": security.imageUrl,
      "usertype": "security"
    });

    await usersDao.updateOrInsertPembina();
  }

  Future<void> createKemanan(Keamanan keamanan) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
      "id":user.uid,
      "name": keamanan.name,
      "address": keamanan.address,
      "age": keamanan.age,
      "phoneNumber": keamanan.phoneNumber,
      "imageUrl": keamanan.imageUrl,
      "usertype": "keamanan"
    });
    await usersDao.updateOrInsertKeamanan();
  }

  Future<void> updateKeamanan(Keamanan keamanan) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .update({
      "id":user.uid,
      "name": keamanan.name,
      "address": keamanan.address,
      "age": keamanan.age,
      "phoneNumber": keamanan.phoneNumber,
      "imageUrl": keamanan.imageUrl,
      "usertype": "security"
    });

    await usersDao.updateOrInsertKeamanan();
  }

  Future<void> createOrangtua(Orangtua orangtua) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection(Constants.USER_COLLECTION).doc(user.uid)
        .set({
      "id":user.uid,
      "idSantri": orangtua.idSantri,
      "name": orangtua.name,
      "address": orangtua.address,
      "age": orangtua.age,
      "imageUrl": orangtua.imageUrl,
      "phoneNumber": orangtua.phoneNumber,
      "usertype": "orangtua"
    });
  }
}