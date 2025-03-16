import 'package:flutter/material.dart';
import 'package:scale_up/presentation/views/authentication/widgets/login_email_field.dart';
import 'package:scale_up/presentation/views/authentication/widgets/login_password_field.dart';

class LoginFieldGroup extends StatelessWidget {
  const LoginFieldGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        spacing: 16.0,
        children: [
          LoginEmailField(),
          LoginPasswordField(),
        ],
      ),
    );
  }
}
