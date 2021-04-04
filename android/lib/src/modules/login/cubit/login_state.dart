part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.usertype = ""});

  final Email email;
  final Password password;
  final FormzStatus status;
  final String usertype;

  @override
  List<Object> get props => [email, password, status, usertype];

  LoginState copyWith(
      {Email? email,
      Password? password,
      FormzStatus? status,
      String? usertype}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        usertype: usertype ?? this.usertype);
  }
}
