import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../models/models.dart';
import '../../../../utils/validator/default_validator.dart';
import '../../../../services/repository/izin_repository/izin_repository.dart';
import '../../../../services/repository/santri_repository/santri_repository.dart';

part 'verval_izin_state.dart';

class VervalIzinCubit extends Cubit<VervalIzinState>{
  VervalIzinCubit(this._izinRepository, this._santriRepository): assert(_izinRepository != null),
        super(VervalIzinState());

  final IzinRepository _izinRepository;
  final SantriRepository _santriRepository;

  void idSantriChanged(String value) {
    final idSantri = Default.dirty(value);
    emit(state.copyWith(
      idSantri: idSantri,
      status: Formz.validate([idSantri])
    ));
  }

  Future<void> searchIzinById() async {
    emit(state.copyWith(izinStatus: IzinStatus.loading));
    _izinRepository.getIzinByIdSantri(state.idSantri.value).then((value) {
      emit(state.copyWith(izin: Izin.fromJson(value.docs.single.data())));
      getSantri();
    }).catchError((error){
      print(error);
      emit(state.copyWith(izinStatus: IzinStatus.failure));
    });
  }

  Future<void> getSantri() async {
    await _santriRepository.getSantriById(state.idSantri.value).then((value){
      emit(state.copyWith(santri: Santri.fromJson(value.data())));
    });
  }

  Future<void> setKepulanganSantri() async {
    await _izinRepository.updateIzin(Izin(), state.izin.id);
  }
}