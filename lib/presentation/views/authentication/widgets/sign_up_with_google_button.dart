import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';
import 'package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart';

class SignUpWithGoogleButton extends StatelessWidget {
  const SignUpWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: () => context
                  .read<SignupPageBloc>()
                  .add(GoogleSignUpButtonPressed()),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.0,
                  children: [
                    Image.asset('assets/logos/google.png',
                        height: 18.0, width: 18.0),
                    Text(
                      'Sign up with Google',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
