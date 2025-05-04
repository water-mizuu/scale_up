import "package:freezed_annotation/freezed_annotation.dart";

part "forgot_password_state.freezed.dart";

@freezed
sealed class ForgotPasswordState with _$ForgotPasswordState {
  const ForgotPasswordState._();

  const factory ForgotPasswordState.initial({required String email}) = InitialForgotPasswordState;

  const factory ForgotPasswordState.sending({required String email}) = SendingForgotPasswordState;
  const factory ForgotPasswordState.success() = SuccessForgotPasswordState;
}
