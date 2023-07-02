import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError {
  empty,
  mismatch,
}

class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordValidationError> {
  final String password;

  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmedPasswordValidationError.empty;
    }
    return password == value ? null : ConfirmedPasswordValidationError.mismatch;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ConfirmedPasswordValidationError.mismatch) return 'Passwords must match';
    if (displayError == ConfirmedPasswordValidationError.empty) return 'The field is requiredl';

    return null;
  }
}

extension Explanation on ConfirmedPasswordValidationError {
  String? get name {
    switch (this) {
      case ConfirmedPasswordValidationError.mismatch:
        return 'passwords must match';
      default:
        return null;
    }
  }
}
