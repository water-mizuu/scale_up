import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/sign_up_page/signup_page_bloc.dart";
import "package:scale_up/presentation/bloc/sign_up_page/signup_page_validator.dart";

class SignUpUsernameField extends StatelessWidget with SignupPageValidator {
  const SignUpUsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateUsername,
      onChanged: (v) => context.read<SignupPageBloc>().add(SignupPageUsernameChanged(v)),
      decoration: InputDecoration(border: OutlineInputBorder(), label: Text("Username")),
    );
  }
}
