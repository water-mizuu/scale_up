import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/SignInPage/sign_in_page_bloc.dart";

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    var authenticationBloc = context.watch<AuthenticationBloc>();

    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: (authenticationBloc.state.status != AuthenticationStatus.signingIn)
                ? () {
                    if (context.read<GlobalKey<FormState>>().currentState?.validate() == true) {
                      var SignInPageState(:email, :password) = context.read().state;
                      var event = EmailSignInAuthenticationEvent(email: email, password: password);

                      authenticationBloc.add(event);
                    }
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
