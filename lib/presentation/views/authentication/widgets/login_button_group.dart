import 'package:flutter/material.dart';
import 'package:scale_up/presentation/views/authentication/widgets/log_in_with_google_button.dart';
import 'package:scale_up/presentation/views/authentication/widgets/login_button.dart';
import 'package:scale_up/presentation/views/authentication/widgets/sign_up_hyperlink_button.dart';

class LoginButtonGroup extends StatelessWidget {
  const LoginButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        LoginButton(),
        // Text('or'),
        // LogInWithGoogleButton(),
        SignUpHyperlinkButton(),
      ],
    );
  }
}
