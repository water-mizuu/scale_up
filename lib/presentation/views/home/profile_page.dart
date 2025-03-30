import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('PROFILE PAGE'),
              ],
            ),
            Expanded(
              child: Center(
                child: TextButton(
                  child: Text('Logout'),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(LogoutAuthenticationEvent());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
