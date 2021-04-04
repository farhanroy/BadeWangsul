part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.usertype = const Default.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final Default usertype;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, usertype, status];

  SignUpState copyWith({
    Email? email,
    Password? password,
    Default? usertype,
    FormzStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      usertype: usertype ?? this.usertype,
      status: status ?? this.status,
    );
  }
}
