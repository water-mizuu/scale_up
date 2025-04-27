import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/firebase/firebase_auth_helper.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_event.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_state.dart";

export "authentication_event.dart";
export "authentication_state.dart";

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required FirebaseAuthHelper repository})
    : _repository = repository,
      super(const AuthenticationState()) {
    on<EmailSignUpAuthenticationEvent>(_onEmailSignup);
    on<GoogleSignInAuthenticationEvent>(_onGoogleSignIn);
    on<EmailSignInAuthenticationEvent>(_onEmailSignIn);
    on<LogoutAuthenticationEvent>(_onLogout);
    on<AuthenticationTokenChangedEvent>(_onAuthenticationTokenChanged);

    _repository.authStateChanges.forEach((user) async {
      add(AuthenticationTokenChangedEvent(user: user));
    });
  }

  final FirebaseAuthHelper _repository;

  void _onEmailSignup(
    EmailSignUpAuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.signingUp, error: null, user: null));

    try {
      var user = await _repository.emailSignUp(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      // Simulate successful authentication
      emit(state.copyWith(status: AuthenticationStatus.signedUp, error: null, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.signUpFailure, error: e));
    }
  }

  void _onEmailSignIn(
    EmailSignInAuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.signingIn, error: null));

    try {
      var user = await _repository
          .emailSignIn(email: event.email, password: event.password)
          .then((u) => u!);

      if (kDebugMode) {
        print("*" * 100);
        print(user);
        print("*" * 100);
      }

      // Simulate successful authentication
      emit(state.copyWith(status: AuthenticationStatus.signedIn, error: null, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.signInFailure, error: e));
    }
  }

  void _onGoogleSignIn(
    GoogleSignInAuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.signingIn, error: null));

    try {
      var user = await _repository.googleSignIn().then((u) => u!);

      // Simulate successful authentication
      emit(state.copyWith(status: AuthenticationStatus.signedIn, error: null, user: user));
    } on PlatformException catch (e) {
      if (e case PlatformException(code: "sign_in_failed", :var message)) {
        if (kDebugMode) {
          print("*" * 100);
          print((message));
          print("*" * 100);
        }
      } else {
        rethrow;
      }
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.signInFailure, error: e));
    }
  }

  void _onLogout(LogoutAuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await _repository.signOut();

      emit(state.copyWith(status: AuthenticationStatus.signedOut, error: null, user: null));
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.signedOut, error: e));
    }
  }

  void _onAuthenticationTokenChanged(
    AuthenticationTokenChangedEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticationStatus.tokenChanging));
    await Future.delayed(Duration.zero);
    emit(
      state.copyWith(
        user: event.user,
        status:
            (event.user != null) //
                ? AuthenticationStatus.signedIn
                : AuthenticationStatus.signedOut,
      ),
    );
  }
}
