import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/santri.dart';
import '../../../utils/constants.dart';

class SantriRepository {

  Future<void> createSantri(Santri santri) async {
    await FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION)
        .doc(santri.id)
        .set({
            "id": santri.id,
            "name": santri.name,
            "age": santri.age,
            "address": santri.address,
            "dormitory": santri.dormitory,
            "birthDate": santri.birthDate,
            "imageUrl": santri.imageUrl
        });
  }

  Future<void> updateSantri(Santri santri) async {
    await FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION)
        .doc(santri.id)
        .update({
      "name": santri.name,
      "age": santri.age,
      "address": santri.address,
      "dormitory": santri.dormitory,
      "birthDate": santri.birthDate,
      "imageUrl": santri.imageUrl
    });
  }

  Future<DocumentSnapshot> getSantriById(String id) async {
    var santri = await FirebaseFirestore.instance
        .collection(Constants.SANTRI_COLLECTION).doc(id).get();
    return santri;
  }
}