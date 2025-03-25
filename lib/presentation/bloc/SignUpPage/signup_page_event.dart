part of 'signup_page_bloc.dart';

sealed class SignupPageEvent {}

class SignupPageUsernameChanged extends SignupPageEvent {
  final String username;
  SignupPageUsernameChanged(this.username);
}

class SignupPagePasswordChanged extends SignupPageEvent {
  final String password;
  SignupPagePasswordChanged(this.password);
}

class SignupPageEmailChanged extends SignupPageEvent {
  final String email;
  SignupPageEmailChanged(this.email);
}

class SignupButtonPressed extends SignupPageEvent {}

class GoogleSignUpButtonPressed extends SignupPageEvent {}
