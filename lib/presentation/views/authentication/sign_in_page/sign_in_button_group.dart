import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:scale_up/presentation/router/app_router.dart";
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
        ForgotPasswordButton(),
        SizedBox(height: 8.0),
        SignInWithGoogleButton(),
        SignUpHyperlinkButton(),
      ],
    );
  }
}

class ForgotPasswordButton extends HookWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Forgot your password?",
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        recognizer:
            TapGestureRecognizer()
              ..onTap = () {
                if (kDebugMode) {
                  print("Going to reset password as clicked by user.");
                }
                router.goNamed(AppRoutes.forgotPassword);
              },
      ),
    );
  }
}
