import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/sign_in_page/sign_in_page_bloc.dart";

class SignInEmailField extends StatelessWidget with SignInPageValidator {
  const SignInEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateEmail,
      onChanged: (value) => context.read<SignInPageBloc>().add(LoginPageEmailChanged(value)),
      decoration: InputDecoration(border: OutlineInputBorder(), label: Text("Email")),
    );
  }
}
