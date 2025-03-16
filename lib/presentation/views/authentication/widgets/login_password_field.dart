import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) =>
          context.read<AuthenticationBloc>().add(AuthenticationPasswordChanged(value)),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text('Password'),
          errorText: context.watch<AuthenticationBloc>().state.passwordError),
      obscureText: true,
    );
  }
}
