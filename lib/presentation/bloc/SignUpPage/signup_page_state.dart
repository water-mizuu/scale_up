part of "signup_page_bloc.dart";

enum SignUpStatus { unknown, invalid, validating, successful }

class SignupPageState {
  final String username;
  final String password;
  final String confirmPassword;
  final String email;
  final SignUpStatus status;
  final String? errorMessage;
  final String passwordStrength;

  const SignupPageState({
    this.username = "",
    this.password = "",
    this.confirmPassword = "",
    this.email = "",
    this.status = SignUpStatus.unknown,
    this.errorMessage,
    this.passwordStrength = "",
  });

  SignupPageState copyWith({
    String? username,
    String? password,
    String? confirmPassword,
    String? email,
    SignUpStatus? status,
    String? errorMessage,
    String? passwordStrength,
  }) {
    return SignupPageState(
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      passwordStrength: passwordStrength ?? this.passwordStrength,
    );
  }
}
