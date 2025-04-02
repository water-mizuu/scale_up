import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/LoginPage/login_page_bloc.dart";
import "package:scale_up/presentation/views/authentication/carousel.login_page.dart";
import "package:scale_up/presentation/views/authentication/login_button_group.login_page.dart";
import "package:scale_up/presentation/views/authentication/login_field_group.login_page.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GlobalKey<FormState>()),
        BlocProvider(create: (_) => LoginPageBloc()),
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        /// We only want to react to the succeeding states
        ///   if the previous state was signing in.
        listenWhen: (previous, _) => previous.status == AuthenticationStatus.signingIn,
        listener: (_, state) {
          if (state
              case AuthenticationState(
                error: FirebaseAuthException(:var code),
                status: AuthenticationStatus.signInFailure,
              )) {
            var message = switch (code) {
              "account-exists-with-different-credential" => //
                "An account already exists with a different credential."
                    "Please try another sign-in method.",
              "invalid-credential" => //
                "Invalid password. Please try again.",
              "operation-not-allowed" => //
                "The operation is not allowed. Please contact support.",
              "user-disabled" => //
                "The corresponding user has been disabled.",
              "user-not-found" => //
                "No user corresponding to the given email was found.",
              "wrong-password" => //
                "The password is invalid for the given email.",
              "invalid-verification-id" => //
                "The verification ID is invalid.",
              "invalid-verification-code" => //
                "The verification code is invalid.",
              _ => //
                "An unknown error occurred. Please contact support.",
            };

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: LoginPageView(),
      ),
    );
  }
}

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            Carousel(),
            LoginFieldGroup(),
            LoginButtonGroup(),
          ],
        ),
      ),
    );
  }
}
