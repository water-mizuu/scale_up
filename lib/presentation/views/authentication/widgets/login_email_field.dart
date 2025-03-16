import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) =>
          context.read<AuthenticationBloc>().add(AuthenticationEmailChanged(value)),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text('Email'),
          errorText: context.watch<AuthenticationBloc>().state.emailError),
    );
  }
}
