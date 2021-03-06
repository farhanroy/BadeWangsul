import 'file:///C:/Users/farhanroy/Documents/project/Bade%20Wangsul/android/lib/src/services/repository/izin_repository/izin_repository.dart';
import 'package:bade_wangsul/src/utils/validator/default_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'create_izin_state.dart';

class CreateIzinCubit extends Cubit<CreateIzinState> {
  CreateIzinCubit(this._izinRepository) : super(CreateIzinState());

  final IzinRepository _izinRepository;

  void titleChanged(String value) {
    final title = Default.dirty(value);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([
        title,
        state.information,
        state.pengasuhName,
        state.pembinaName,
        state.santriName,
        state.fromDate,
        state.toDate
      ]),
    ));
  }

  void informationChanged(String value) {
    final title = Default.dirty(value);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([
        title,
        state.information,
        state.pengasuhName,
        state.pembinaName,
        state.santriName,
        state.fromDate,
        state.toDate
      ]),
    ));
  }


}