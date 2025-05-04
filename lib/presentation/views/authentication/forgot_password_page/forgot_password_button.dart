import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/bloc/forgot_password_page/forgot_password_bloc.dart";

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.select((ForgotPasswordBloc b) => b.state);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          onPressed: () {
            var isProcessing = state is SendingForgotPasswordState;

            if (isProcessing) {
              return null;
            }

            return () async {
              // if (state is! InitialForgotPasswordState) {
              //   return;
              // }

              context.read<ForgotPasswordBloc>().add(ForgotPasswordSubmitting());

              // context.read<AuthenticationBloc>().add(
              //   PasswordResetAuthenticationEvent(email: state.email),
              // );

              /// Validate the form.

              // if (context.read<GlobalKey<FormState>>().currentState?.validate() == true) {
              //   var SignupPageState(:username, :email, :password, :passwordStrength) =
              //       context.read<SignupPageBloc>().state;

              //   if (!context.mounted) return;

              //   var event = EmailSignUpAuthenticationEvent(
              //     username: username,
              //     email: email,
              //     password: password,
              //   );

              //   context.read<AuthenticationBloc>().add(event);
              // }
            };
          }(),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("Send an email", style: TextStyle(fontSize: 16.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextButton(child: Text("Back to Login"), onPressed: () => context.pop()),
      ],
    );
  }
}
