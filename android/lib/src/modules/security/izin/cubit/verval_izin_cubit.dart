import 'package:bade_wangsul/src/models/izin.dart';
import 'package:bade_wangsul/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
      getSantri();
    }).catchError((error){
      print(error);
      emit(state.copyWith(izinStatus: IzinStatus.failure));
    });
  }

  Future<void> getSantri() async {
    await _santriRepository.getSantriById(state.idSantri.value).then((value) => );
  }
}