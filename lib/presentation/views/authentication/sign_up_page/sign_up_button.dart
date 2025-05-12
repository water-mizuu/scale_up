import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/sign_up_page/signup_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    var status = context.select((AuthenticationBloc b) => b.state.status);
    var isProcessing = status == AuthenticationStatus.signingUp;

    return Row(
      children: [
        Expanded(
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            onPressed: () {
              if (isProcessing) return null;

              return () async {
                /// Validate the form.
                if (context.read<GlobalKey<FormState>>().currentState?.validate() == true) {
                  var SignupPageState(:username, :email, :password, :passwordStrength) =
                      context.read<SignupPageBloc>().state;

                  if (passwordStrength != "Strong") {
                    FocusManager.instance.primaryFocus?.unfocus();
                    var shouldContinue = await context.showConfirmationDialog(
                      title: "Weak password",
                      message:
                          "Are you sure you want to register using your password? "
                          "It might not be fully strong.",
                    );

                    if (!shouldContinue) return;
                  }

                  if (!context.mounted) return;

                  var event = EmailSignUpAuthenticationEvent(
                    username: username,
                    email: email,
                    password: password,
                  );

                  context.read<AuthenticationBloc>().add(event);
                }
              };
            }(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Builder(
                builder: (context) {
                  if (isProcessing) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                            strokeWidth: 2.0,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text("Signing Up", style: TextStyle(fontSize: 16.0)),
                      ],
                    );
                  } else {
                    return const Text("Sign Up", style: TextStyle(fontSize: 16.0));
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
