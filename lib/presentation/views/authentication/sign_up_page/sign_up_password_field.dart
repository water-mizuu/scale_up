import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/SignUpPage/signup_page_bloc.dart";
import "package:scale_up/presentation/bloc/SignUpPage/signup_page_validator.dart";

double _getStrengthValue(String strength) {
  return switch (strength) {
    "Weak" => 0.33,
    "Medium" => 0.66,
    "Strong" => 1.0,
    _ => 0.0,
  };
}

Color _getStrengthColor(String strength) {
  return switch (strength) {
    "Weak" => Colors.red,
    "Medium" => Colors.orange,
    "Strong" => Colors.green,
    _ => Colors.grey,
  };
}

class SignUpPasswordField extends StatefulWidget {
  const SignUpPasswordField({super.key});

  @override
  State<SignUpPasswordField> createState() => _SignUpPasswordFieldState();
}

class _SignUpPasswordFieldState extends State<SignUpPasswordField> with SignupPageValidator {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupPageBloc, SignupPageState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              obscureText: _obscureText,
              validator: validatePassword,
              onChanged: (v) => context.read<SignupPageBloc>().add(SignupPagePasswordChanged(v)),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: OutlineInputBorder(),
                label: Text("Password"),
              ),
            ),
            // if (state.passwordStrength.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FAProgressBar(
                    size: 4.0,
                    backgroundColor: Colors.grey,
                    currentValue: _getStrengthValue(state.passwordStrength) * 100,
                    progressColor: _getStrengthColor(state.passwordStrength),
                  ),
                  Text(
                    state.passwordStrength,
                    style: TextStyle(
                      color:
                          state.passwordStrength == "Strong"
                              ? Colors.green
                              : state.passwordStrength == "Medium"
                              ? Colors.orange
                              : state.passwordStrength == "Weak"
                              ? Colors.red
                              : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
