import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';


class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField({super.key});

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      onChanged: (value) =>
          context.read<AuthenticationBloc>().add(AuthenticationPasswordChanged(value)),
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          border: OutlineInputBorder(),
          label: Text('Password'),
          errorText: context.watch<AuthenticationBloc>().state.passwordError),
    );
  }
}
