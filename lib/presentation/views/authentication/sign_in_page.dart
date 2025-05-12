import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/hooks/providing_hook_widget.dart";
import "package:scale_up/hooks/use_bloc_listener.dart";
import "package:scale_up/hooks/use_new_bloc.dart";
import "package:scale_up/presentation/bloc/authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/sign_in_page/sign_in_page_bloc.dart";
import "package:scale_up/presentation/views/authentication/sign_in_page/carousel.dart";
import "package:scale_up/presentation/views/authentication/sign_in_page/sign_in_button_group.dart";
import "package:scale_up/presentation/views/authentication/sign_in_page/sign_in_field_group.dart";
import "package:scale_up/utils/extensions/snackbar_extension.dart";

class SignInPage extends ProvidingHookWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = useMemoized(() => GlobalKey<FormState>());
    context.provide(formKey);

    var bloc = useCreateBloc(() => SignInPageBloc());
    context.provideBloc(bloc);

    useBlocListener(
      context.read<AuthenticationBloc>(),
      (state) {
        if (state case AuthenticationState(
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

          if (kDebugMode) {
            print("Error: $message");
          }
          context.showBasicSnackbar(message);
        }
      },
      listenWhen: (p, _) => p.status == AuthenticationStatus.signingIn,
    );

    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            children: [Carousel(), SignInFieldGroup(), SignInButtonGroup()],
          ),
        ),
      ),
    );
  }
}
