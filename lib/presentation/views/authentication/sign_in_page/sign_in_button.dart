import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/sign_in_page/sign_in_page_bloc.dart";

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    late var authenticationBloc = context.watch<AuthenticationBloc>();
    late var globalKey = context.read<GlobalKey<FormState>>();
    late var signInPageBloc = context.read<SignInPageBloc>();

    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed:
                (authenticationBloc.state.status != AuthenticationStatus.signingIn)
                    ? () {
                      if (globalKey.currentState?.validate() == true) {
                        var SignInPageState(:email, :password) = signInPageBloc.state;
                        var event = EmailSignInAuthenticationEvent(
                          email: email,
                          password: password,
                        );

                        authenticationBloc.add(event);
                      }
                    }
                    : null,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("Login", style: TextStyle(fontSize: 16.0)),
            ),
          ),
        ),
      ],
    );
  }
}
