sealed class SignInPageEvent {}

class LoginPageEmailChanged extends SignInPageEvent {
  final String email;

  LoginPageEmailChanged(this.email);
}

class LoginPagePasswordChanged extends SignInPageEvent {
  final String password;
  LoginPagePasswordChanged(this.password);
}

class LoginPageFormSwiped extends SignInPageEvent {
  final int position;

  LoginPageFormSwiped(this.position);
}
