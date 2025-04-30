import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";

class ConfirmingLeaveChapterWidget extends StatelessWidget {
  const ConfirmingLeaveChapterWidget({super.key, required this.shouldConfirm});

  final bool shouldConfirm;

  @override
  Widget build(BuildContext context) {
    var color = context.read<HSLColor>();

    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () async {
        if (!shouldConfirm) {
          context.pop();
          return;
        }

        WillPopScope;
        var hasConfirmed = await context.showConfirmationDialog(
          title: "Quit?",
          message: "Are you sure you want to quit? Your progress will **NOT** be saved.",
          cancelButtonText: "Return",
          confirmButtonText: "Quit",
          cancelButtonColor: color.toColor(),
          confirmButtonColor: Color(0xFFC63A3A),
        );

        if (context.mounted && hasConfirmed) {
          context.pop();
        }
      },
    );
  }
}
