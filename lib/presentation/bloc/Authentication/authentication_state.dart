enum AuthenticationStatus {
  authenticated,
  authenticating,
  unauthenticated,
  none,
  error,
}

const undefined = #undefined;

class AuthenticationState {
  const AuthenticationState({
    this.status = AuthenticationStatus.none,
    this.error,
  });

  final AuthenticationStatus status;
  final Object? error;

  AuthenticationState Function({
    AuthenticationStatus? status,
    Object? error,
  }) get copyWith => _copyWith;

  AuthenticationState _copyWith({
    Object? status = undefined,
    Object? error = undefined,
  }) {
    return AuthenticationState(
      status: status.or(this.status),
      error: error.or(this.error),
    );
  }
}

extension on Object? {
  T or<T>(T value) => this == undefined ? value : this as T;
}
