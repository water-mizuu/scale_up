const undefined = #undefined;

class SignInPageState {
  final String email;
  final String password;
  final int carouselPosition;

  const SignInPageState({
    this.email = "",
    this.password = "",
    this.carouselPosition = 0,
  });

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  SignInPageState Function({
    String? email,
    String? password,
    int? carouselPosition,
  }) get copyWith => _copyWith;

  SignInPageState _copyWith({
    Object? email = undefined,
    Object? password = undefined,
    Object? carouselPosition = undefined,
  }) {
    return SignInPageState(
      email: email.or(this.email),
      password: password.or(this.password),
      carouselPosition: carouselPosition.or(this.carouselPosition),
    );
  }
}

extension on Object? {
  T or<T>(T value) => this == undefined ? value : this as T;
}
