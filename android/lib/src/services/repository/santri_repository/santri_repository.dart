import 'package:bade_wangsul/src/models/santri.dart';
import 'package:bade_wangsul/src/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SantriRepository {

  Future<void> createSantri(Santri santri) async {
    await FirebaseFirestore.instance.collection(Constants.SANTRI_COLLECTION)
        .doc()
        .set({
            "name": santri.name,
            "age": santri.age,
            "address": santri.address,
            "dormitory": santri.dormitory,
            "imageUrl": santri.imagePath
        });
  }

}