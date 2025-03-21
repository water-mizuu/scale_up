part of 'signup_page_bloc.dart';

enum SignUpStatus {unknown, successful, unsuccessful}
class SignupPageState {
  final String username;
  final String password;
  final String email;
  final SignUpStatus status;
  final String errorMessage;
  final String successMessage;

  const SignupPageState({
    this.username = '',
    this.password = '',
    this.email = '',
    this.status = SignUpStatus.unknown,
    this.errorMessage = '',
    this.successMessage = '',
  });

  SignupPageState copyWith({
    String? username,
    String? password,
    String? email,
    SignUpStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return SignupPageState(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      status: status?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
