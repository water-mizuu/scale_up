import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart';
import 'package:scale_up/presentation/bloc/SignUpPage/signup_page_validator.dart';

class SignUpConfirmPasswordField extends StatelessWidget with SignupPageValidator {
  const SignUpConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    var signUpPageBloc = context.read<SignupPageBloc>();

    return TextFormField(
      obscureText: true,
      validator: (v) => validateConfirmPassword(v, signUpPageBloc.state.password),
      onChanged: (v) => signUpPageBloc.add(SignUpPageConfirmPasswordChanged(v)),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Confirm Password'),
      ),
    );
  }
}
