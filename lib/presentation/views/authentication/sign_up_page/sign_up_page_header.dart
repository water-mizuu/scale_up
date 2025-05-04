import "package:flutter/material.dart";

class SignUpPageHeader extends StatelessWidget {
  const SignUpPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Create an account",
      style: TextStyle(fontSize: 20.0),
      textAlign: TextAlign.center,
    );
  }
}
