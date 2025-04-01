import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/repositories/authentication/authentication_repository.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_event.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_state.dart";

export "package:scale_up/presentation/bloc/Authentication/authentication_event.dart";
export "package:scale_up/presentation/bloc/Authentication/authentication_state.dart";

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationRepository repository})
      : _repository = repository,
        super(const AuthenticationState()) {
    on<EmailSignUpAuthenticationEvent>(_onEmailSignup);
    on<GoogleSignInAuthenticationEvent>(_onGoogleSignIn);
    on<EmailSignInAuthenticationEvent>(_onEmailSignIn);
    on<LogoutAuthenticationEvent>(_onLogout);
    on<AuthenticationTokenChangedEvent>(_onAuthenticationChangeNotification);

    _repository.authStateChanges.forEach((user) async {
      print("New authentication token: $user");
      add(AuthenticationTokenChangedEvent(user: user));
    });
  }

  final AuthenticationRepository _repository;

  void _onEmailSignup(
    EmailSignUpAuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.authenticating, error: null));

    try {
      await _repository.emailSignUp(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      // Simulate successful authentication
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated, error: null));
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated, error: e));
    }
  }

  void _onEmailSignIn(
    EmailSignInAuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.authenticating, error: null));

    try {
      var user = (await _repository.emailSignIn(email: event.email, password: event.password))!;

      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful authentication
      emit(state.copyWith(status: AuthenticationStatus.authenticated, error: null, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated, error: e));
    }
  }

  void _onGoogleSignIn(
    GoogleSignInAuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.authenticating, error: null));

    try {
      var user = (await _repository.googleSignIn())!;

      // Simulate successful authentication
      emit(state.copyWith(status: AuthenticationStatus.authenticated, error: null, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated, error: e));
    }
  }

  void _onLogout(LogoutAuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await _repository.signOut();

      // Simulate successful logout
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated, error: null, user: null));
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated, error: e));
    }
  }

  void _onAuthenticationChangeNotification(
    AuthenticationTokenChangedEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      state.copyWith(
        user: event.user,
        status: event.user != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated,
      ),
    );
  }
}
