import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart';
import 'package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart';
import 'package:scale_up/presentation/router/app_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupPageBloc, SignupPageState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.successful) {
          final String email = context.read<SignupPageBloc>().state.email;
          final String password = context.read<SignupPageBloc>().state.password;
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationEmailChanged(email));
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationPasswordChanged(password));
          context.read<AuthenticationBloc>().add(AuthenticationFormSubmitted());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
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
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [],
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(54.0),
      child: Image.asset('assets/illustrations/signup.png'),
    );
  }
}

class SignUpFieldGroup extends StatelessWidget {
  const SignUpFieldGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        spacing: 8.0,
        children: [
          SignUpUsernameField(),
          SignUpEmailField(),
          SignUpPasswordField(),
        ],
      ),
    );
  }
}

class SignUpEmailField extends StatelessWidget {
  const SignUpEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (value) =>
            context.read<SignupPageBloc>().add(SignupPageEmailChanged(value)),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text('Email'),
        ));
  }
}

class SignUpUsernameField extends StatelessWidget {
  const SignUpUsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (value) => context
            .read<SignupPageBloc>()
            .add(SignupPageUsernameChanged(value)),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text('Username'),
        ));
  }
}

class SignUpPasswordField extends StatelessWidget {
  const SignUpPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (value) => context
            .read<SignupPageBloc>()
            .add(SignupPagePasswordChanged(value)),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text('Password'),
        ));
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
              onPressed: () =>
                  context.read<SignupPageBloc>().add(SignupButtonPressed()),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 16.0),
                ),
              )),
        ),
      ],
    );
  }
}
