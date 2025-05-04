import "package:flutter_bloc/flutter_bloc.dart";

part "signup_page_event.dart";
part "signup_page_state.dart";

class SignupPageBloc extends Bloc<SignupPageEvent, SignupPageState> {
  SignupPageBloc() : super(const SignupPageState()) {
    on<SignupPageUsernameChanged>(_onUsernameChanged);
    on<SignupPagePasswordChanged>(_onPasswordChanged);
    on<SignUpPageConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupPageEmailChanged>(_onEmailChanged);
  }

  String _checkPasswordStrength(String password) {
    final strong = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$");
    final medium = RegExp(r"^((?=.*[a-z])(?=.*[A-Z])|(?=.*[a-z])(?=.*\d)).{6,}$");

    if (strong.hasMatch(password)) return "Strong";
    if (medium.hasMatch(password)) return "Medium";
    return "Weak";
  }

  void _onUsernameChanged(SignupPageUsernameChanged event, Emitter emit) {
    final username = event.username;
    emit(state.copyWith(username: username));
  }

  void _onPasswordChanged(SignupPagePasswordChanged event, Emitter emit) {
    final password = event.password;
    final strength = password.isEmpty ? "" : _checkPasswordStrength(password);
    emit(state.copyWith(password: password, passwordStrength: strength));
  }

  void _onConfirmPasswordChanged(SignUpPageConfirmPasswordChanged event, Emitter emit) {
    final confirmPassword = event.confirmPassword;
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void _onEmailChanged(SignupPageEmailChanged event, Emitter emit) {
    final email = event.email;
    emit(state.copyWith(email: email));
  }
}
