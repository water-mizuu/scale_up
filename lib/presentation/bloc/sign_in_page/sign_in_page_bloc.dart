import "package:bloc/bloc.dart";
import "package:scale_up/presentation/bloc/sign_in_page/sign_in_page_event.dart";
import "package:scale_up/presentation/bloc/sign_in_page/sign_in_page_state.dart";

export "sign_in_page_event.dart";
export "sign_in_page_state.dart";
export "sign_in_page_validator.dart";

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  SignInPageBloc() : super(const SignInPageState()) {
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
