import "package:firebase_auth/firebase_auth.dart";

sealed class AuthenticationEvent {
  const AuthenticationEvent();
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

class AuthenticationTokenChangedEvent extends AuthenticationEvent {
  const AuthenticationTokenChangedEvent({
    required this.user,
  });

  final User? user;
}
