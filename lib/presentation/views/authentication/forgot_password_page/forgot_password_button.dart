import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/bloc/forgot_password_page/forgot_password_bloc.dart";

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.select((ForgotPasswordBloc b) => b.state);
    var isProcessing = state is SendingForgotPasswordState;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          onPressed: () {
            if (isProcessing) return null;

            return () {
              context.read<ForgotPasswordBloc>().add(const ForgotPasswordSubmitting());
            };
          }(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Builder(
              builder: (context) {
                if (isProcessing) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                          strokeWidth: 2.0,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text("Sending Email...", style: TextStyle(fontSize: 16.0)),
                    ],
                  );
                } else {
                  return const Text("Send Reset Link", style: TextStyle(fontSize: 16.0));
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        TextButton(child: const Text("Back to Login"), onPressed: () => context.pop()),
      ],
    );
  }
}
