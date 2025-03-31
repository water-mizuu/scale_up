import "package:bloc/bloc.dart";
import "package:scale_up/presentation/bloc/LoginPage/login_page_event.dart";
import "package:scale_up/presentation/bloc/LoginPage/login_page_state.dart";

export "login_page_event.dart";
export "login_page_state.dart";
export "login_page_validator.dart";

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(const LoginPageState()) {
    on<LoginPageEmailChanged>(_onEmailChanged);
    on<LoginPagePasswordChanged>(_onPasswordChanged);
    on<LoginPageFormSwiped>((event, emit) {});
  }

  void _onEmailChanged(LoginPageEmailChanged event, Emitter emit) {
    final email = event.email;

    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(LoginPagePasswordChanged event, Emitter emit) {
    final password = event.password;

    emit(state.copyWith(password: password));
  }
}
