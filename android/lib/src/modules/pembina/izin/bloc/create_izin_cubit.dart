import 'package:bade_wangsul/src/models/izin.dart';
import 'package:bade_wangsul/src/services/repository/izin_repository/izin_repository.dart';
import 'package:bade_wangsul/src/utils/validator/date_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../utils/validator/default_validator.dart';
import '../../../../models/santri.dart';
import '../../../../services/repository/santri_repository/santri_repository.dart';

part 'create_izin_state.dart';

class CreateIzinCubit extends Cubit<CreateIzinState> {

  final SantriRepository santriRepository;
  final IzinRepository izinRepository;

  CreateIzinCubit(this.santriRepository, this.izinRepository) : super(CreateIzinState());

  void idSantriChanged(String value) {
    emit(state.copyWith(idSantri: value));
  }

  void currentStepChanged(int value) {
    emit(state.copyWith(currentStep: value));
  }

  void santriChanged() {
    santriRepository.getSantriById(state.idSantri).then((documentSnapshot) {
      emit(state.copyWith(santri: Santri.fromJson(documentSnapshot.data())));
    });
  }
  
  void titleChanged(String value) {
    final title = Default.dirty(value);
    emit(state.copyWith(
      title: title,
      information: state.information,
      fromDate: state.fromDate,
      toDate: state.toDate,
      status: Formz.validate([
        title, 
        state.information,
        state.fromDate,
        state.toDate
      ]) 
    ));
  }

  void informationChanged(String value) {
    final information = Default.dirty(value);
    emit(state.copyWith(
        title: state.title,
        information: information,
        fromDate: state.fromDate,
        toDate: state.toDate,
        status: Formz.validate([
          state.title,
          information,
          state.fromDate,
          state.toDate
        ])
    ));
  }
  void fromDateChanged(DateTime value) {
    final fromDate = Date.dirty(value);
    emit(state.copyWith(
        title: state.title,
        information: state.information,
        fromDate: fromDate,
        toDate: state.toDate,
        status: Formz.validate([
          state.title,
          state.information,
          fromDate,
          state.toDate
        ])
    ));
  }
  void toDateChanged(DateTime value) {
    final toDate = Date.dirty(value);
    emit(state.copyWith(
        title: state.title,
        information: state.information,
        fromDate: state.fromDate,
        toDate: toDate,
        status: Formz.validate([
          state.title,
          state.information,
          state.fromDate,
          toDate
        ])
    ));
  }

  Future<void> createIzin(String idPembina) async {
    await izinRepository.createIzin(Izin(
      idSantri: state.idSantri,
      idPembina: idPembina,
      title: state.title.value,
      information: state.information.value,
      fromDate: state.fromDate.value,
      toDate: state.toDate.value,
    ));
  }
}