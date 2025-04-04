import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart";

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: context.watch<AuthenticationBloc>().state.status != //
                    AuthenticationStatus.signingUp
                ? () {
                    /// Validate the form.
                    if (context.read<GlobalKey<FormState>>().currentState?.validate() == true) {
                      var SignupPageState(:username, :email, :password) =
                          context.read<SignupPageBloc>().state;

                      var event = EmailSignUpAuthenticationEvent(
                        username: username,
                        email: email,
                        password: password,
                      );

                      context.read<AuthenticationBloc>().add(event);
                    }
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
