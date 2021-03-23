part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final Email email;
  final FormzStatus status;

  const ForgotPasswordState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure
  });
  
  @override
  List<Object> get props => [email, status];
  
  ForgotPasswordState copyWith({
    Email? email,
    FormzStatus? status
  }) => ForgotPasswordState(
    email: email ?? this.email,
    status: status ?? this.status
  );
}