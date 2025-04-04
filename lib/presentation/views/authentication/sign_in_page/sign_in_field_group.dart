import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/views/authentication/sign_in_page/sign_in_email_field.dart";
import "package:scale_up/presentation/views/authentication/"
    "sign_in_page/sign_in_password_field.dart";

class SignInFieldGroup extends StatelessWidget {
  const SignInFieldGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Form(
        key: context.read<GlobalKey<FormState>>(),
        child: const Column(
          spacing: 16.0,
          children: [
            SignInEmailField(),
            SignInPasswordField(),
          ],
        ),
      ),
    );
  }
}
