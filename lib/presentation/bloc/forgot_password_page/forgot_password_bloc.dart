import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/forgot_password_page/forgot_password_event.dart";
import "package:scale_up/presentation/bloc/forgot_password_page/forgot_password_state.dart";

export "forgot_password_event.dart";
export "forgot_password_state.dart";

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState.initial(email: "")) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitting>(_onSubmitting);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (state case InitialForgotPasswordState state) {
      emit(state.copyWith(email: event.email));
    } else if (state is! InitialForgotPasswordState) {
      emit(InitialForgotPasswordState(email: event.email));
    }
  }

  void _onSubmitting(ForgotPasswordSubmitting event, Emitter<ForgotPasswordState> emit) async {
    if (state case InitialForgotPasswordState state) {
      emit(ForgotPasswordState.sending(email: state.email));
    }
  }

  void _onSubmitted(ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordState.success());
  }
}
