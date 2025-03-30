import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/LoginPage/login_page_bloc.dart';
import 'package:scale_up/presentation/views/authentication/login_email_field.login_page.dart';
import 'package:scale_up/presentation/views/authentication/login_password_field.login_page.dart';

class LoginFieldGroup extends StatelessWidget {
  const LoginFieldGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Form(
        key: context.read<LoginPageBloc>().formKey,
        child: Column(
          spacing: 16.0,
          children: [
            LoginEmailField(),
            LoginPasswordField(),
          ],
        ),
      ),
    );
  }
}
