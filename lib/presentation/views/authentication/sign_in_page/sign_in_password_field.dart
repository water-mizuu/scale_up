import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/SignInPage/sign_in_page_bloc.dart";

class SignInPasswordField extends StatefulWidget {
  const SignInPasswordField({super.key});

  @override
  State<SignInPasswordField> createState() => _SignInPasswordFieldState();
}

class _SignInPasswordFieldState extends State<SignInPasswordField> with SignInPageValidator {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatePassword,
      obscureText: _obscureText,
      onChanged: (value) => context.read<SignInPageBloc>().add(LoginPagePasswordChanged(value)),
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
        label: Text("Password"),
      ),
    );
  }
}
