import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/forgot_password_page/forgot_password_bloc.dart";
import "package:scale_up/presentation/bloc/forgot_password_page/forgot_password_validator.dart";

class ForgotPasswordEmailField extends StatelessWidget with ForgotPasswordValidatorMixin {
  const ForgotPasswordEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        validator: validateEmail,
        onChanged: (value) {
          context.read<ForgotPasswordBloc>().add(ForgotPasswordEmailChanged(value));
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Email Address",
          prefixIcon: Icon(Icons.email_outlined),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
