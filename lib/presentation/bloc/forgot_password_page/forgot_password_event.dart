sealed class ForgotPasswordEvent {}

final class ForgotPasswordEmailChanged implements ForgotPasswordEvent {
  const ForgotPasswordEmailChanged(this.email);

  final String email;
}

final class ForgotPasswordButtonPressed implements ForgotPasswordEvent {
  const ForgotPasswordButtonPressed();
}

final class ForgotPasswordSubmitting implements ForgotPasswordEvent {
  const ForgotPasswordSubmitting();
}

final class ForgotPasswordSubmitted implements ForgotPasswordEvent {
  const ForgotPasswordSubmitted();
}
