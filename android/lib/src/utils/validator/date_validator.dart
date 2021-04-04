import 'package:formz/formz.dart';

enum DateValidationError { invalid }

class Date extends FormzInput<DateTime?, DateValidationError> {
  const Date.pure() : super.pure(null);

  const Date.dirty([DateTime? value]) : super.dirty(value);

  @override
  DateValidationError? validator(DateTime? value) {
    return value != null ? null : DateValidationError.invalid;
  }
}
