import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/notifications/user_quit_notification.dart";

class ConfirmingLeaveChapterWidget extends StatelessWidget {
  const ConfirmingLeaveChapterWidget({super.key, required this.shouldConfirm});

  final bool shouldConfirm;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          UserQuitNotification().dispatch(context);
        },
        child: const Icon(Icons.arrow_back, size: 18.0),
      ),
    );
  }
}
