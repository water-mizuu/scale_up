import "package:firebase_auth/firebase_auth.dart";

enum AuthenticationStatus {
  none,
  error,

  signedOut,

  /// Logging in states.
  signedIn,
  signingIn,
  signInFailure,

  /// Signing up states
  signedUp,
  signingUp,
  signUpFailure,
}

const undefined = #undefined;

class AuthenticationState {
  const AuthenticationState({
    this.user,
    this.status = AuthenticationStatus.none,
    this.error,
  });

  final User? user;
  final AuthenticationStatus status;
  final Object? error;

  AuthenticationState Function({
    User? user,
    AuthenticationStatus? status,
    Object? error,
  }) get copyWith => _copyWith;

  AuthenticationState _copyWith({
    Object? user = undefined,
    Object? status = undefined,
    Object? error = undefined,
  }) {
    return AuthenticationState(
      user: user.or(this.user),
      status: status.or(this.status),
      error: error.or(this.error),
    );
  }

  @override
  String toString() => "AuthenticationState(user: $user, status: $status, error: $error)";
}

extension on Object? {
  T or<T>(T value) => this == undefined ? value : this as T;
}
