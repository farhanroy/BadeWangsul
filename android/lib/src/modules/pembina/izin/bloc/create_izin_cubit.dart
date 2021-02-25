import 'package:bade_wangsul/src/utils/validator/default_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_izin_state.dart';

class CreateIzinCubit extends Cubit<CreateIzinState>{
  CreateIzinCubit(CreateIzinState state) : super(state);
}