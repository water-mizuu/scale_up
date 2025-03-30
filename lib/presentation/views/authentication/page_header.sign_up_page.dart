import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create an account',
      style: TextStyle(fontSize: 20.0),
      textAlign: TextAlign.center,
    );
  }
}
