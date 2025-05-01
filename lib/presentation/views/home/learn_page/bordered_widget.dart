import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";

class UnselectedWidget extends StatelessWidget {
  const UnselectedWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(8.0),
      dashPattern: [4, 4],
      strokeWidth: 2.0,
      color: Colors.transparent,
      child: child,
    );
  }
}

class SelectedWidget extends StatelessWidget {
  const SelectedWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(8.0),
      dashPattern: [4, 4],
      strokeWidth: 2.0,
      color: Colors.blue,
      child: child,
    );
  }
}

class CorrectWidget extends StatelessWidget {
  const CorrectWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8.0),
          dashPattern: [4, 4],
          strokeWidth: 2.0,
          color: Colors.green,
          child: child,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Transform.translate(
            offset: const Offset(8.0, -8.0),
            child: Icon(Icons.check_circle, color: Colors.green, size: 24.0),
          ),
        ),
      ],
    );
  }
}

class IncorrectWidget extends StatelessWidget {
  const IncorrectWidget({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8.0),
          dashPattern: [4, 4],
          strokeWidth: 2.0,
          color: Colors.red,
          child: widget,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Transform.translate(
            offset: const Offset(8.0, -8.0),
            child: Icon(Icons.cancel, color: Colors.red, size: 24.0),
          ),
        ),
      ],
    );
  }
}
