part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, unauthenticated, authenticated }

const undefined = #undefined;

class AuthenticationState {
  final String email;
  final String password;
  final bool isSubmitting;
  final AuthenticationStatus status;
  final String? emailError;
  final String? passwordError;
  // final User? user;
  final int carouselPosition;

  AuthenticationState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.emailError,
    this.passwordError,
    this.status = AuthenticationStatus.unknown,
    // this.user,
    this.carouselPosition = 0,
  });
  bool get isValid =>
      emailError == null &&
      passwordError == null &&
      email.isNotEmpty &&
      password.isNotEmpty;

  late final AuthenticationState Function({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isSubmitting,
    AuthenticationStatus? status,
    // User? user,
    int? carouselPosition,
  }) copyWith = _copyWith;

  AuthenticationState _copyWith({
    Object? email = undefined,
    Object? password = undefined,
    Object? emailError = undefined,
    Object? passwordError = undefined,
    Object? isSubmitting = undefined,
    Object? status = undefined,
    // User? user = undefined,
    Object? carouselPosition = undefined,
  }) {
    return AuthenticationState(
      email: email.or(this.email),
      password: password.or(this.password),
      emailError: emailError.or(this.emailError),
      passwordError: passwordError.or(this.passwordError),
      isSubmitting: isSubmitting.or(this.isSubmitting),
      status: status.or(this.status),
      // user: user.or(this.user),
      carouselPosition: carouselPosition.or(this.carouselPosition),
    );
  }
}

extension on Object? {
  T or<T>(T value) => this == undefined ? value : this as T;
}
