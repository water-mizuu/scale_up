import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:markdown_widget/widget/markdown.dart";
import "package:scale_up/presentation/bloc/context_dialog/context_dialog_cubit.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";
import "package:scale_up/utils/extensions/unindent_extension.dart";

class ContextDialogWidget extends StatefulWidget {
  const ContextDialogWidget({super.key, required this.child});

  final Widget? child;

  static ContextDialogCubit of(BuildContext context) => context.read();

  @override
  State<ContextDialogWidget> createState() => _ContextDialogWidgetState();
}

class _ContextDialogWidgetState extends State<ContextDialogWidget> {
  late final ContextDialogCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = ContextDialogCubit()..stream.listen(_streamListener);
  }

  @override
  void dispose() {
    cubit.close();

    super.dispose();
  }

  void _streamListener(ContextDialogState state) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var state = cubit.state;
    var dialog = switch (state) {
      ShowConfirmationDialog() => Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.white.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MarkdownWidget(
              data:
                  """
                  ### ${state.title}

                  ${state.message}
                  """.unindent(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16.0),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: state.cancelButtonColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: state.onCancelPressed,
              child: Text(
                state.cancelButtonText,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: state.onConfirmPressed,
              child: Text(
                state.confirmButtonText,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: state.confirmButtonColor,
                ),
              ),
            ),
          ],
        ),
      ),
      ShowInfoDialog() => Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.white.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MarkdownWidget(
              data:
                  """
                  ### ${state.title}

                  ${state.message}
                  """.unindent(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16.0),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: state.buttonColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: state.onPressed,
              child: Text(
                state.buttonText,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      HiddenConfirmationDialog() => null as Widget?,
    };

    if (dialog != null) {
      dialog = dialog
          .animate() //
          .slideY(duration: 250.ms, begin: 1.0, end: 0.0, curve: Curves.easeOutQuad);
    }

    return BlocProvider.value(
      value: cubit,
      child: Material(
        child: Stack(
          children: [
            if (widget.child case var child?) Positioned.fill(child: child),
            if (dialog case var dialog?) ...[
              /// This is the barrier.
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => cubit.cancelDialogs(),
                  child: const ColoredBox(color: Colors.transparent),
                ),
              ),

              /// This is the dialog itself.
              Positioned(bottom: 0, left: 0, right: 0, child: dialog),
            ],
          ],
        ),
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
