import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/sign_up_page/signup_page_bloc.dart";
import "package:scale_up/presentation/bloc/sign_up_page/signup_page_validator.dart";

class SignUpConfirmPasswordField extends StatefulWidget {
  const SignUpConfirmPasswordField({super.key});

  @override
  State<SignUpConfirmPasswordField> createState() => _SignUpConfirmPasswordFieldState();
}

class _SignUpConfirmPasswordFieldState extends State<SignUpConfirmPasswordField> with SignupPageValidator {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var signUpPageBloc = context.read<SignupPageBloc>();

    return TextFormField(
      obscureText: _obscureText,
      validator: (v) => validateConfirmPassword(v, signUpPageBloc.state.password),
      onChanged: (v) => signUpPageBloc.add(SignUpPageConfirmPasswordChanged(v)),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: const Text("Confirm Password"),
        // Updated suffix icon to match sign_up_password_field.dart
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
