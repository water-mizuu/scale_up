import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/sign_up_page/signup_page_bloc.dart";
import "package:scale_up/presentation/bloc/sign_up_page/signup_page_validator.dart";

class SignUpEmailField extends StatelessWidget with SignupPageValidator {
  const SignUpEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateEmail,
      onChanged: (v) => context.read<SignupPageBloc>().add(SignupPageEmailChanged(v)),
      decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Email")),
    );
  }
}
