import "package:flutter/material.dart";

class ForgotPasswordDescription extends StatelessWidget {
  const ForgotPasswordDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Enter your email to receive a password reset link",
        style: TextStyle(
          fontSize: 14.0,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
