import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "signup_page_event.dart";
part "signup_page_state.dart";

class SignupPageBloc extends Bloc<SignupPageEvent, SignupPageState> {
  SignupPageBloc() : super(SignupPageState(formKey: GlobalKey<FormState>())) {
    on<SignupPageUsernameChanged>(_onUsernameChanged);
    on<SignupPagePasswordChanged>(_onPasswordChanged);
    on<SignUpPageConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupPageEmailChanged>(_onEmailChanged);
    on<SignupButtonPressed>(_onButtonPressed);
  }

  GlobalKey<FormState> get formKey => state.formKey;

  void _onUsernameChanged(SignupPageUsernameChanged event, Emitter emit) {
    final username = event.username;
    emit(state.copyWith(username: username));
  }

  void _onPasswordChanged(SignupPagePasswordChanged event, Emitter emit) {
    final password = event.password;
    emit(state.copyWith(password: password));
  }

  void _onConfirmPasswordChanged(SignUpPageConfirmPasswordChanged event, Emitter emit) {
    final confirmPassword = event.confirmPassword;
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void _onEmailChanged(SignupPageEmailChanged event, Emitter emit) {
    final email = event.email;
    emit(state.copyWith(email: email));
  }

  Future<void> _onButtonPressed(SignupButtonPressed event, Emitter emit) async {
    if (state.formKey.currentState?.validate() case true) {
      emit(state.copyWith(status: SignUpStatus.validating));
      try {
        emit(state.copyWith(status: SignUpStatus.successful));
      } catch (e) {
        emit(state.copyWith(status: SignUpStatus.invalid));
      }
    } else {
      emit(state.copyWith(status: SignUpStatus.invalid));
    }
  }
}
