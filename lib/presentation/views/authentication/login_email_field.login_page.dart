import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LoginPage/login_page_bloc.dart";

class LoginEmailField extends StatelessWidget with LoginPageValidator {
  const LoginEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateEmail,
      onChanged: (value) => context.read<LoginPageBloc>().add(LoginPageEmailChanged(value)),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Email"),
      ),
    );
  }
}
