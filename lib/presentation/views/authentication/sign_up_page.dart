import 'package:flutter/material.dart';
import 'package:scale_up/presentation/router/app_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: SizedBox(
              height: 24.0,
              child: IconButton(
                  onPressed: () {
                    router.pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            children: [
              PageHeader(),
              ImageContainer(),
              SignUpFieldGroup(),
              SignUpButton(),
            ],
          ),
        ));
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Sign Up',
          style: TextStyle(fontSize: 22.0),
          textAlign: TextAlign.center,
        ),
      ],
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
        onChanged: (value) => {},
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text('Email'),
        ));
  }
}

class SignUpPasswordField extends StatelessWidget {
  const SignUpPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (value) => {},
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
              onPressed: () {},
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
