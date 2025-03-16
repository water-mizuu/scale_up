import 'package:flutter/material.dart';

class LogInWithGoogleButton extends StatelessWidget {
  const LogInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.0,
                  children: [
                    Image.asset('assets/logos/google.png', height: 18.0, width: 18.0),
                    Text(
                      'Log in with Google',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
