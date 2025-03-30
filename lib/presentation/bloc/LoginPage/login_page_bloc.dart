import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scale_up/presentation/bloc/LoginPage/login_page_event.dart';
import 'package:scale_up/presentation/bloc/LoginPage/login_page_state.dart';

export 'login_page_event.dart';
export 'login_page_state.dart';
export 'login_page_validator.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageState(formKey: GlobalKey<FormState>())) {
    on<LoginPageEmailChanged>(_onEmailChanged);
    on<LoginPagePasswordChanged>(_onPasswordChanged);
    on<LoginPageFormSwiped>((event, emit) {});
  }

  GlobalKey<FormState> get formKey => state.formKey;

  void _onEmailChanged(LoginPageEmailChanged event, Emitter emit) {
    final email = event.email;

    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(LoginPagePasswordChanged event, Emitter emit) {
    final password = event.password;

    emit(state.copyWith(password: password));
  }

  // void _onSubmitted(LoginPageFormSubmitted event, Emitter emit) async {
  //   emit(state.copyWith(status: LoginPageStatus.validating));

  //   /// Create a short delay to show progress to the user
  //   if (kDebugMode) {
  //     print(state.formKey.currentState?.validate());
  //   }

  //   if (state.formKey.currentState?.validate() case true) {
  //     emit(state.copyWith(
  //       status: LoginPageStatus.submitting,
  //       loginMode: EmailLoginMode(email: state.email, password: state.password),
  //     ));
  //   } else {
  //     emit(state.copyWith(status: LoginPageStatus.failed));
  //   }
  // }
}
