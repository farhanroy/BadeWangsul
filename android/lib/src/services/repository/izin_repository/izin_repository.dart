import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/izin.dart';
import '../../../utils/constants.dart';

class IzinRepository {
  Future<void> createIzin(Izin izin) async {
    await FirebaseFirestore.instance.collection(Constants.IZIN_COLLECTION)
        .doc()
        .set(Izin().toJson(izin));
  }
}