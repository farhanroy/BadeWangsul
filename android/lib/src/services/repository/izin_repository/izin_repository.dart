import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/izin.dart';
import '../../../utils/constants.dart';

class IzinRepository {
  Future<void> createIzin(Izin izin) async {
    await FirebaseFirestore.instance.collection(Constants.IZIN_COLLECTION)
        .doc()
        .set(Izin().toJson(izin));
  }

  Future<void> updateIzin(Izin izin, String? idIzin) async {
    await FirebaseFirestore.instance.collection(Constants.IZIN_COLLECTION)
        .doc(idIzin)
        .update(Izin().toJson(izin));
  }

  Future<QuerySnapshot> getIzinByIdSantri(String? id) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(Constants.IZIN_COLLECTION)
        .where("idSantri", isEqualTo: id)
        .get();
    return snapshot;
  }
}