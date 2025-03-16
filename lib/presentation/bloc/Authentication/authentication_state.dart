part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, unauthenticated, authenticated }

class AuthenticationState {
  final String email;
  final String password;
  final bool isSubmitting;
  final AuthenticationStatus status;
  final String? emailError;
  final String? passwordError;
  final User? user;
  final int carouselPosition;

  AuthenticationState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.emailError,
    this.passwordError,
    this.status = AuthenticationStatus.unknown,
    this.user,
    this.carouselPosition = 0,
  });
  bool get isValid =>
      emailError == null && passwordError == null && email.isNotEmpty && password.isNotEmpty;

  AuthenticationState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isSubmitting,
    AuthenticationStatus? status,
    User? user,
    int? carouselPosition,
  }) {
    return AuthenticationState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      status: status ?? this.status,
      user: user ?? this.user,
      carouselPosition: carouselPosition ?? this.carouselPosition,
    );
  }
}
