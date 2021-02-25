part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.username = const Default.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.usertype = const Default.pure(),
    this.status = FormzStatus.pure,
  });

  final Default username;
  final Email email;
  final Password password;
  final Default usertype;
  final FormzStatus status;

  @override
  List<Object> get props => [username, email, password, usertype, status];

  SignUpState copyWith({
    Default username,
    Email email,
    Password password,
    Default usertype,
    FormzStatus status,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      usertype: usertype ?? this.usertype,
      status: status ?? this.status,
    );
  }
}
