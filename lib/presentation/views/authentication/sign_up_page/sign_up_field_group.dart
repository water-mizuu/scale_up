import "package:flutter/material.dart";
import "package:scale_up/presentation/views/authentication/sign_up_page/sign_up_confirm_password_field.dart";
import "package:scale_up/presentation/views/authentication/sign_up_page/sign_up_email_field.dart";
import "package:scale_up/presentation/views/authentication/sign_up_page/sign_up_password_field.dart";
import "package:scale_up/presentation/views/authentication/sign_up_page/sign_up_username_field.dart";

class SignUpFieldGroup extends StatelessWidget {
  const SignUpFieldGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        spacing: 8.0,
        children: [
          SignUpUsernameField(),
          SignUpEmailField(),
          SignUpPasswordField(),
          SignUpConfirmPasswordField()
        ],
      ),
    );
  }
}
