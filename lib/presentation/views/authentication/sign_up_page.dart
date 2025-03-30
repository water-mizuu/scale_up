import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';
import 'package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart';
import 'package:scale_up/presentation/router/app_router.dart';
import 'package:scale_up/presentation/views/authentication/image_container.sign_up_page.dart';
import 'package:scale_up/presentation/views/authentication/page_header.sign_up_page.dart';
import 'package:scale_up/presentation/views/authentication/sign_up_button.sign_up_page.dart';
import 'package:scale_up/presentation/views/authentication/sign_up_field_group.sign_up_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupPageBloc, SignupPageState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.successful) {
          var SignupPageState(:email, :password) = context.read<SignupPageBloc>().state;

          context.read<AuthenticationBloc>()
            ..add(AuthenticationEmailChanged(email))
            ..add(AuthenticationPasswordChanged(password))
            ..add(AuthenticationFormSubmitted());
        }
      },
      child: Scaffold(
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
        body: Padding(
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
