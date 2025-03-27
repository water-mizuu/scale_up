import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/data/repositories/authentication/authentication_repository.dart';
import 'package:scale_up/firebase_auth/firebase_authentication.dart';

part 'signup_page_event.dart';
part 'signup_page_state.dart';

class SignupPageBloc extends Bloc<SignupPageEvent, SignupPageState> {
  SignupPageBloc({required AuthenticationRepositoryImpl repository})
      : super(const SignupPageState()) {
    on<SignupPageUsernameChanged>(_onUsernameChanged);
    on<SignupPagePasswordChanged>(_onPasswordChanged);
    on<SignupPageEmailChanged>(_onEmailChanged);
    on<SignupButtonPressed>(_onButtonPressed);
  }

  void _onUsernameChanged(SignupPageUsernameChanged event, Emitter emit) {
    final username = event.username;
    emit(state.copyWith(username: username));
  }

  void _onPasswordChanged(SignupPagePasswordChanged event, Emitter emit) {
    final password = event.password;
    emit(state.copyWith(password: password));
  }

  void _onEmailChanged(SignupPageEmailChanged event, Emitter emit) {
    final email = event.email;
    emit(state.copyWith(email: email));
  }

  Future<void> _onButtonPressed(SignupButtonPressed event, Emitter emit) async {
    final password = state.password;
    if (password.length < 6) {
      emit(state.copyWith(
          errorMessage: "Password must be at least 6 characters"));
    } else {
      try {
        await UserAuth().signup(
            username: state.username,
            email: state.email,
            password: state.password);
        emit(state.copyWith(
          status: SignUpStatus.successful,
        ));
      } catch (e) {
        emit(state.copyWith(
            status: SignUpStatus.unsuccessful,
            errorMessage: "Signup failed: ${e.toString()}"));
      }
    }
  }
}
