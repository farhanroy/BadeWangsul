import 'package:bade_wangsul/src/models/santri.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../../../models/izin.dart';
import '../../../../services/repository/izin_repository/izin_repository.dart';

part 'detail_izin_state.dart';

class DetailIzinCubit extends Cubit<DetailIzinState> {
  DetailIzinCubit(this._izinRepository, {this.idIzin})
      : assert(_izinRepository != null),
        super(DetailIzinState()) {
    izinChanged();
  }

  final IzinRepository _izinRepository;
  final String? idIzin;

  void izinChanged() async {
    await FirebaseFirestore.instance
        .collection(Constants.IZIN_COLLECTION)
        .doc(idIzin)
        .get()
        .then((documentSnapshot) {
      emit(state.copyWith(izin: Izin.fromJson(documentSnapshot.data()!)));
    });
    await getSantri();
    print(state.izin!.idSantri);
  }

  Future<void> getSantri() async {
    await FirebaseFirestore.instance
        .collection(Constants.SANTRI_COLLECTION)
        .doc(state.izin!.idSantri)
        .get()
        .then((documentSnapshot) {
      emit(state.copyWith(santri: Santri.fromJson(documentSnapshot.data()!)));
    });
  }

  Future<void> verificationIzin() async {
    emit(state.copyWith(status: DetailIzinStatus.loading));
    try {
      await _izinRepository.updateIzin(
          Izin(
            idSantri: state.izin!.idSantri,
            idPembina: state.izin!.idPembina,
            title: state.izin!.title,
            information: state.izin!.information,
            fromDate: state.izin!.fromDate,
            toDate: state.izin!.toDate,
            isPermissioned: true,
            isPulang: false,
          ),
          idIzin);
      emit(state.copyWith(status: DetailIzinStatus.success));
    } on Exception {
      emit(state.copyWith(status: DetailIzinStatus.failure));
    }
  }
}
