import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';
import 'package:scale_up/presentation/bloc/LoginPage/login_page_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: (context.watch<AuthenticationBloc>().state.status !=
                    AuthenticationStatus.authenticating)
                ? () {
                    if (context.read<LoginPageBloc>().formKey.currentState?.validate() == true) {
                      var LoginPageState(:email, :password) = context.read<LoginPageBloc>().state;
                      var event = EmailSignInAuthenticationEvent(email: email, password: password);

                      context.read<AuthenticationBloc>().add(event);
                    }
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
