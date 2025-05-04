import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/sign_in_page/sign_in_page_bloc.dart";

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    late var authenticationBloc = context.watch<AuthenticationBloc>();
    late var globalKey = context.read<GlobalKey<FormState>>();
    late var signInPageBloc = context.read<SignInPageBloc>();

    final isProcessing = authenticationBloc.state.status == AuthenticationStatus.signingIn;

    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: () {
              if (isProcessing) return null;

              return () {
                if (globalKey.currentState?.validate() == true) {
                  var SignInPageState(:email, :password) = signInPageBloc.state;
                  var event = EmailSignInAuthenticationEvent(email: email, password: password);

                  authenticationBloc.add(event);
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
                        const Text("Logging In", style: TextStyle(fontSize: 16.0)),
                      ],
                    );
                  } else {
                    return const Text("Login", style: TextStyle(fontSize: 16.0));
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
