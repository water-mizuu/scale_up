import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/authentication/image_container.sign_up_page.dart";
import "package:scale_up/presentation/views/authentication/page_header.sign_up_page.dart";
import "package:scale_up/presentation/views/authentication/sign_up_button.sign_up_page.dart";
import "package:scale_up/presentation/views/authentication/sign_up_field_group.sign_up_page.dart";

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => SignupPageBloc(),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) => previous.status == AuthenticationStatus.signingUp,
        listener: (context, state) {
          if (state
              case AuthenticationState(
                error: FirebaseAuthException(:var code),
                status: AuthenticationStatus.signUpFailure,
              )) {
            var message = switch (code) {
              "weak-password" => //
                // TODO: Add an indicator of a password strength to the form.
                "The password is too weak. Please try a stronger one!",
              "email-already-in-use" =>
                "The email is already connected with another account. Please try another email.",
              "invalid-email" => //
                "The email address is not valid. Please check and try again.",
              "operation-not-allowed" => //
                "Email/password accounts are not enabled. Please contact support.",
              "network-request-failed" => //
                "A network error occurred. Please check your connection and try again.",
              _ => "An unknown error occurred. Please try again. Code: $code",
            };

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: SignUpPageView(),
      ),
    );
  }
}

class SignUpPageView extends StatelessWidget {
  const SignUpPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PageHeader(),
        leading: SizedBox(
          height: 24.0,
          child: IconButton(
            onPressed: () {
              router.pop();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: context.read<SignupPageBloc>().formKey,
            child: Column(
              spacing: 16.0,
              children: [
                ImageContainer(),
                SignUpFieldGroup(),
                SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
