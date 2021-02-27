import 'package:bade_wangsul/src/repository/authentication_repository/authentication_repository.dart';
import 'package:bade_wangsul/src/repository/user_repository/user_repository.dart';
import 'package:bade_wangsul/src/utils/validator/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'signup_state.dart';

class   SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository, this._userRepository)
      : assert(_authenticationRepository != null),
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  void usernameChanged(String value) {
    final username = Default.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        username,
        state.email,
        state.password,
        state.usertype
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.username,
        email,
        state.password,
        state.usertype
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.username,
        state.email,
        password,
        state.usertype
      ]),
    ));
  }

  void usertypeChanged(String value) {
    final usertype = Default.dirty(value);
    emit(state.copyWith(
      usertype: usertype,
      status: Formz.validate([
        state.username,
        state.email,
        state.password,
        usertype
      ]),
    ));
  }


  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      await _userRepository.setUserData(
          username: state.username.value,
          usertype: state.username.value
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
