import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/hooks/providing_hook_widget.dart";
import "package:scale_up/hooks/use_bloc_listener.dart";
import "package:scale_up/presentation/bloc/authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/forgot_password_page/forgot_password_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/authentication/forgot_password_page/"
    "forgot_password_button.dart";
import "package:scale_up/presentation/views/authentication/forgot_password_page/"
    "forgot_password_description.dart";
import "package:scale_up/presentation/views/authentication/forgot_password_page/"
    "forgot_password_email_field.dart";
import "package:scale_up/presentation/views/authentication/forgot_password_page/"
    "forgot_password_image_container.dart";
import "package:scale_up/presentation/views/authentication/forgot_password_page/"
    "forgot_password_page_header.dart";
import "package:scale_up/utils/extensions/snackbar_extension.dart";

class ForgotPasswordPage extends ProvidingHookWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var globalKey = useMemoized(() => GlobalKey<FormState>());
    context.provide(globalKey);

    var authenticationBloc = context.read<AuthenticationBloc>();
    var forgotPasswordBloc = useProvidedBloc(() => ForgotPasswordBloc());

    useBlocListener(forgotPasswordBloc, (state) {
      if (state case SendingForgotPasswordState(:var email)) {
        authenticationBloc.add(PasswordResetAuthenticationEvent(email: email));
      }

      if (state case SuccessForgotPasswordState()) {
        if (router.canPop()) {
          router.pop();
        } else {
          router.goNamed("login");
        }
      }
    });

    useBlocListener(authenticationBloc, (state) {
      if (state case AuthenticationState(:var error?)) {
        if (kDebugMode) {
          print("Error: ${error.runtimeType}");
        }
        context.showBasicSnackbar(error.toString());
        forgotPasswordBloc.add(const ForgotPasswordReset());
      } else {
        forgotPasswordBloc.add(const ForgotPasswordSubmitted());
      }
    }, listenWhen: (p, _) => p.status == AuthenticationStatus.resettingEmail);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => router.pop(),
        ),
        title: const ForgotPasswordPageHeader(),
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: globalKey,
            child: const Column(
              children: [
                ForgotPasswordImageContainer(),
                ForgotPasswordDescription(),
                ForgotPasswordEmailField(),
                ForgotPasswordButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
