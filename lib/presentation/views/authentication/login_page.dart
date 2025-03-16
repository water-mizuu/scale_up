import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';
import 'package:scale_up/presentation/router/app_router.dart';
import 'package:scale_up/presentation/views/authentication/widgets/login_button_group.dart';
import 'package:scale_up/presentation/views/authentication/widgets/carousel.dart';
import 'package:scale_up/presentation/views/authentication/widgets/login_field_group.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          router.goNamed('home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 16.0,
              children: [
                Carousel(),
                // Pagination(),
                LoginFieldGroup(),
                LoginButtonGroup(),
              ],
            ),
          ),
        );
      },
    );
  }
}
