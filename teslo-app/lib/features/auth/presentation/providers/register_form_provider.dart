import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/infrastucture/inputs/full_name.dart';
import 'package:teslo_shop/features/shared/infrastucture/inputs/inputs.dart';

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;

  RegisterFormNotifier({
    required this.registerUserCallback,
  }) : super(RegisterFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail, 
      isValid: Formz.validate([newEmail, state.fullName, state.password, state.confirmedPassword])
    );
  }

  onFullnameChanged(String value) {
    final newFullName = FullName.dirty(value);

    state = state.copyWith(
      fullName: newFullName, 
      isValid: Formz.validate([newFullName, state.email, state.password, state.confirmedPassword])
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.confirmedPassword, state.fullName, state.email]));
  }

  onConfirmedPasswordChanged(String value) {
    final newPassword = ConfirmedPassword.dirty(
      value: value,
      password: state.password.value
    );
    state = state.copyWith(
        confirmedPassword: newPassword,
        isValid: Formz.validate([newPassword, state.password, state.fullName, state.email]));
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

   await registerUserCallback(state.email.value, state.password.value, state.fullName.value);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final fullName = FullName.dirty(state.fullName.value);
    final password = Password.dirty(state.password.value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: state.confirmedPassword.value
    );

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      fullName: fullName,
      password: password,
      confirmedPassword: confirmedPassword,
      isValid: Formz.validate([email, fullName, password, confirmedPassword]),
    );
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final FullName fullName;
  final Password password;
  final ConfirmedPassword confirmedPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(), 
    this.fullName = const FullName.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    FullName? fullName,
    Password? password,
    ConfirmedPassword? confirmedPassword,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
    confirmedPassword: confirmedPassword ?? this.confirmedPassword,
    fullName: fullName ?? this.fullName,
  );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
    fullName: $fullName
    password: $password
    password: $confirmedPassword
''';
  }
}