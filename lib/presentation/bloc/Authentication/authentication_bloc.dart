import 'package:bloc/bloc.dart';
import 'package:scale_up/data/models/user.dart';
import 'package:scale_up/data/repositories/authentication/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationRepositoryImpl repository})
      : _repository = repository,
        super(AuthenticationState()) {
    on<AuthenticationEmailChanged>(_onEmailChanged);
    on<AuthenticationPasswordChanged>(_onPasswordChanged);
    on<AuthenticationFormSubmitted>(_onSubmitted);
    on<AuthenticationRevoked>((event, emit) {});
    on<AuthenticationFormSwiped>((event, emit) {});
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
      final user = User.empty;
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(
        isSubmitting: false,
        status: AuthenticationStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        status: AuthenticationStatus.unauthenticated,
      ));
    }
  }
}
