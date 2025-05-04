import "package:flutter/material.dart";

class ForgotPasswordPageHeader extends StatelessWidget {
  const ForgotPasswordPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Reset Password",
      style: TextStyle(fontSize: 20.0),
      textAlign: TextAlign.center,
    );
  }
}
