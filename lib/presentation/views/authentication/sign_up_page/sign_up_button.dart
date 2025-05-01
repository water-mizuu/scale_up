import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    var status = context.select((AuthenticationBloc b) => b.state.status);

    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: () {
              var isProcessing = status == AuthenticationStatus.signingUp;

              if (isProcessing) {
                return null;
              }

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
              padding: EdgeInsets.all(12.0),
              child: Text("Sign Up", style: TextStyle(fontSize: 16.0)),
            ),
          ),
        ),
      ],
    );
  }
}
