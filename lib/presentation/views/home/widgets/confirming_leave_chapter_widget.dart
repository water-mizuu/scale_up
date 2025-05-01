import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/notifications/user_quit_notification.dart";

class ConfirmingLeaveChapterWidget extends StatelessWidget {
  const ConfirmingLeaveChapterWidget({super.key, required this.shouldConfirm});

  final bool shouldConfirm;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () {
        UserQuitNotification().dispatch(context);
      },
    );
  }
}
