import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart";
import "package:scale_up/presentation/bloc/SignUpPage/signup_page_validator.dart";

class SignUpPasswordField extends StatefulWidget {
  const SignUpPasswordField({super.key});

  @override
  State<SignUpPasswordField> createState() => _SignUpPasswordFieldState();
}

class _SignUpPasswordFieldState extends State<SignUpPasswordField> with SignupPageValidator {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      validator: validatePassword,
      onChanged: (v) => context.read<SignupPageBloc>().add(SignupPagePasswordChanged(v)),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(),
        label: Text("Password"),
      ),
    );
  }
}
