import "package:flutter/material.dart";

class ForgotPasswordImageContainer extends StatelessWidget {
  const ForgotPasswordImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(56.0),
        child: Image.asset("assets/illustrations/signup.png"),
      ),
    );
  }
}
