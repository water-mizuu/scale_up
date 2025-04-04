import "package:flutter_bloc/flutter_bloc.dart";

part "signup_page_event.dart";
part "signup_page_state.dart";

class SignupPageBloc extends Bloc<SignupPageEvent, SignupPageState> {
  SignupPageBloc() : super(SignupPageState()) {
    on<SignupPageUsernameChanged>(_onUsernameChanged);
    on<SignupPagePasswordChanged>(_onPasswordChanged);
    on<SignUpPageConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupPageEmailChanged>(_onEmailChanged);
  }

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
}
