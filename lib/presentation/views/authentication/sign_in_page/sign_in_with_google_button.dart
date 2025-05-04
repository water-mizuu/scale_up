import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/authentication/authentication_bloc.dart";

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              context //
                  .read<AuthenticationBloc>()
                  .add(const GoogleSignInAuthenticationEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8.0,
                children: [
                  Image.asset("assets/logos/google.png", height: 18.0, width: 18.0),
                  const Text("Log in with Google", style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
