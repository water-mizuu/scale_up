part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

class AuthenticationEmailChanged extends AuthenticationEvent {
  final String email;

  AuthenticationEmailChanged(this.email);
}

class AuthenticationPasswordChanged extends AuthenticationEvent {
  final String password;
  AuthenticationPasswordChanged(this.password);
}

class AuthenticationFormSubmitted extends AuthenticationEvent {}

class AuthenticationRevoked extends AuthenticationEvent {}

class AuthenticationFormSwiped extends AuthenticationEvent {
  final int position;
  AuthenticationFormSwiped(this.position);
}
