import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:provider/provider.dart";
import "package:scale_up/hooks/use_bloc_listener.dart";
import "package:scale_up/hooks/use_new_bloc.dart";
import "package:scale_up/presentation/bloc/authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/forgot_password_page/forgot_password_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/authentication/forgot_password_page/"
    "forgot_password_button.dart";
import "package:scale_up/presentation/views/authentication/forgot_password_page/"
    "forgot_password_image_container.dart";
import "package:scale_up/presentation/views/authentication/forgot_password_page/"
    "forgot_password_page_header.dart";
import "package:scale_up/utils/extensions/snackbar_extension.dart";

class ForgotPasswordPage extends HookWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var globalKey = useRef(GlobalKey<FormState>()).value;
    var authenticationBloc = context.read<AuthenticationBloc>();
    var forgotPasswordBloc = useCreateNewBloc(() => ForgotPasswordBloc());

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
      } else {
        forgotPasswordBloc.add(ForgotPasswordSubmitted());
      }
    }, listenWhen: (p, _) => p.status == AuthenticationStatus.resettingEmail);

    return MultiProvider(
      providers: [
        InheritedProvider.value(value: globalKey),
        BlocProvider.value(value: forgotPasswordBloc),
      ],
      child: ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ForgotPasswordPageHeader(),
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
            key: context.read<GlobalKey<FormState>>(),
            child: Column(
              spacing: 16.0,
              children: [
                ForgotPasswordImageContainer(),
                Column(
                  children: [
                    TextFormField(
                      onChanged: (v) {
                        context.read<ForgotPasswordBloc>().add(ForgotPasswordEmailChanged(v));
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email Address"),
                      ),
                    ),
                  ],
                ),
                ForgotPasswordButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
