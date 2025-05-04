import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:scale_up/presentation/router/app_router.dart";

class SignUpHyperlinkButton extends StatelessWidget {
  const SignUpHyperlinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account?",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          const WidgetSpan(child: SizedBox(width: 8.0)),
          TextSpan(
            text: "Sign Up",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    if (kDebugMode) {
                      print("Going to sign up as clicked by user.");
                    }
                    router.goNamed(AppRoutes.signUp);
                  },
          ),
        ],
      ),
    );
  }
}
