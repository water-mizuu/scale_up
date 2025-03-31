sealed class AuthenticationEvent {
  const AuthenticationEvent();

  const factory AuthenticationEvent.emailSignup({
    required String username,
    required String email,
    required String password,
  }) = EmailSignUpAuthenticationEvent;

  const factory AuthenticationEvent.emailSignIn({
    required String email,
    required String password,
  }) = EmailSignInAuthenticationEvent;

  const factory AuthenticationEvent.googleSignIn() = GoogleSignInAuthenticationEvent;
  const factory AuthenticationEvent.logout() = LogoutAuthenticationEvent;
}

class EmailSignUpAuthenticationEvent extends AuthenticationEvent {
  const EmailSignUpAuthenticationEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  final String username;
  final String email;
  final String password;
}

class EmailSignInAuthenticationEvent extends AuthenticationEvent {
  const EmailSignInAuthenticationEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class GoogleSignInAuthenticationEvent extends AuthenticationEvent {
  const GoogleSignInAuthenticationEvent();
}

class LogoutAuthenticationEvent extends AuthenticationEvent {
  const LogoutAuthenticationEvent();
}
