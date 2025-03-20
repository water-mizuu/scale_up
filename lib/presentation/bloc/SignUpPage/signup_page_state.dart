part of 'signup_page_bloc.dart';

class SignupPageState {
  final String username;
  final String password;
  final String email;
  final String errorMessage;
  final String successMessage;

  const SignupPageState({
    this.username = '',
    this.password = '',
    this.email = '',
    this.errorMessage = '',
    this.successMessage = '',
  });

  SignupPageState copyWith({
    String? username,
    String? password,
    String? email,
    String? errorMessage,
    String? successMessage,
  }) {
    return SignupPageState(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
