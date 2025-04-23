import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_markdown_plus/flutter_markdown_plus.dart";
import "package:scale_up/presentation/bloc/ContextDialog/context_dialog_cubit.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";

class ContextDialogWidget extends StatelessWidget {
  const ContextDialogWidget({super.key, required this.child});

  final Widget? child;

  static ContextDialogCubit of(BuildContext context) => context.read();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContextDialogCubit(),
      child: Builder(
        builder: (context) {
          var cubit = context.watch<ContextDialogCubit>();
          var state = cubit.state;
          var dialog = switch (state) {
            ShowConfirmationDialog() => Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [defaultBoxShadow.first.copyWith(offset: Offset(0, -2))],
              ),
              child: Column(
                spacing: 12.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    spacing: 4.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Markdown(
                        data: "## ${state.title}",
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                      ),
                      Markdown(data: state.message, shrinkWrap: true, padding: EdgeInsets.zero),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 4.0,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: state.cancelButtonColor),
                        onPressed: state.onCancelPressed,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            state.cancelButtonText,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: state.onConfirmPressed,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              state.confirmButtonText,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                color: state.confirmButtonColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ShowInfoDialog() => Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [defaultBoxShadow.first.copyWith(offset: Offset(0, -2))],
              ),
              child: Column(
                spacing: 12.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    spacing: 4.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Markdown(
                        data: "## ${state.title}",
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                      ),
                      Markdown(data: state.message, shrinkWrap: true, padding: EdgeInsets.zero),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 4.0,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: state.buttonColor),
                        onPressed: state.onPressed,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            state.buttonText,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            HiddenConfirmationDialog() => null as Widget?,
          };

          if (dialog != null) {
            dialog = dialog
                .animate() //
                .slideY(duration: 250.ms, begin: 1.0, end: 0.0, curve: Curves.linearToEaseOut);
          }

          return Stack(
            children: [
              if (child case var child?) Positioned.fill(child: child),
              if (dialog case var dialog?) ...[
                /// This is the barrier.
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => cubit.cancelDialogs(),
                    child: ColoredBox(color: Colors.transparent),
                  ),
                ),

                /// This is the dialog itself.
                Positioned(bottom: 0, left: 0, right: 0, child: dialog),
              ],
            ],
          );
        },
      ),
    );
  }
}

extension ContextDialogExtension on BuildContext {
  Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String? cancelButtonText,
    String? confirmButtonText,
    VoidCallback? onCancelPressed,
    VoidCallback? onConfirmPressed,
    Color? cancelButtonColor,
    Color? confirmButtonColor,
  }) {
    var completer = Completer<bool>.sync();

    ContextDialogWidget.of(this).showConfirmationDialog(
      title: title,
      message: message,
      cancelText: cancelButtonText,
      confirmText: confirmButtonText,
      onCancelPressed: () {
        onCancelPressed?.call();
        completer.complete(false);
      },
      onConfirmPressed: () {
        onConfirmPressed?.call();
        completer.complete(true);
      },
      cancelButtonColor: cancelButtonColor ?? Colors.redAccent,
      confirmButtonColor: confirmButtonColor ?? Colors.blue,
    );

    return completer.future;
  }
}
