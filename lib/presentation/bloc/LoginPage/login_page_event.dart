sealed class LoginPageEvent {}

class LoginPageEmailChanged extends LoginPageEvent {
  final String email;

  LoginPageEmailChanged(this.email);
}

class LoginPagePasswordChanged extends LoginPageEvent {
  final String password;
  LoginPagePasswordChanged(this.password);
}

class LoginPageFormSwiped extends LoginPageEvent {
  final int position;

  LoginPageFormSwiped(this.position);
}
