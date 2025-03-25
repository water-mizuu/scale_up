import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scale_up/data/models/user.dart';
import 'package:scale_up/data/repositories/authentication/authentication_repository.dart';
import 'package:scale_up/firebase_auth/firebase_authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationRepositoryImpl repository})
      : _repository = repository,
        super(AuthenticationState()) {
    on<AuthenticationEmailChanged>(_onEmailChanged);
    on<AuthenticationPasswordChanged>(_onPasswordChanged);
    on<AuthenticationFormSubmitted>(_onSubmitted);
    on<AuthenticationRevoked>((event, emit) {});
    on<AuthenticationFormSwiped>((event, emit) {});
    on<GoogleSignInButtonPressed>(_onGoogleSignIn);
  }

  final AuthenticationRepositoryImpl _repository;

  void _onEmailChanged(AuthenticationEmailChanged event, Emitter emit) {
    final email = event.email;

    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(AuthenticationPasswordChanged event, Emitter emit) {
    final password = event.password;

    emit(state.copyWith(password: password));
  }

  void _onSubmitted(AuthenticationFormSubmitted event, Emitter emit) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: state.email, password: state.password);
      emit(state.copyWith(
        isSubmitting: false,
        status: AuthenticationStatus.authenticated,
      ));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        status: AuthenticationStatus.unauthenticated,
      ));
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void _onGoogleSignIn(GoogleSignInButtonPressed event, Emitter emit) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      final UserCredential? userCredential = await UserAuth().googleSignIn();
      print(userCredential);
      if (userCredential != null) {
        emit(state.copyWith(
          isSubmitting: false,
          status: AuthenticationStatus.authenticated,
        ));
      } else {
        print("Failed");
      }
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        status: AuthenticationStatus.unauthenticated,
      ));
      print("Google Sign-In Failed: $e");
    }
  }
}
