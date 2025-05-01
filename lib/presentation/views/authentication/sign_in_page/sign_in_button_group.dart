import "package:flutter/material.dart";
import "package:scale_up/presentation/views/authentication/sign_in_page/sign_in_button.dart";
import "package:scale_up/presentation/views/authentication/sign_in_page/sign_in_with_google_button.dart";
import "package:scale_up/presentation/views/authentication/sign_in_page/sign_up_hyperlink_button.dart";

class SignInButtonGroup extends StatelessWidget {
  const SignInButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 8,
      children: [
        SignInButton(),
        SignInWithGoogleButton(),
        SignUpHyperlinkButton(),
      ],
    );
  }
}
