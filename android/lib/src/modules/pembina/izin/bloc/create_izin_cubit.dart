import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../utils/validator/default_validator.dart';

part 'create_izin_state.dart';

class CreateIzinCubit extends Cubit<CreateIzinState> {
  CreateIzinCubit() : super(CreateIzinState());

  void idSantriChanged(String value) {
    emit(state.copyWith(idSantri: value));
  }

  void currentStepChanged(int value) {
    emit(state.copyWith(currentStep: value));
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
  void fromDateChanged(String value) {
    final fromDate = Default.dirty(value);
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
  void toDateChanged(String value) {
    final toDate = Default.dirty(value);
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
}