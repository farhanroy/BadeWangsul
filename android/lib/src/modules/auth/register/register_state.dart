import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class RegisterState extends Equatable{
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({@required this.error});

  @override
  List<Object> get props => [error];
}