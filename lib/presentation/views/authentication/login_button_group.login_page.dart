import 'package:flutter/material.dart';
import 'package:scale_up/presentation/views/authentication/login_button.login_page.dart';
import 'package:scale_up/presentation/views/authentication/login_with_google_button.login_page.dart';
import 'package:scale_up/presentation/views/authentication/sign_up_hyperlink_button.login_page.dart';

class LoginButtonGroup extends StatelessWidget {
  const LoginButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        LoginButton(),
        Text('or'),
        LoginWithGoogleButton(),
        SignUpHyperlinkButton(),
      ],
    );
  }
}
