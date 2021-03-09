import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_izin_state.dart';

class CreateIzinCubit extends Cubit<CreateIzinState> {
  CreateIzinCubit() : super(CreateIzinState());

  void idSantriChanged(String value) {
    emit(state.copyWith(idSantri: value));
  }

}