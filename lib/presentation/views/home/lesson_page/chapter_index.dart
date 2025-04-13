import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class ChapterIndex extends StatelessWidget {
  const ChapterIndex({super.key, required this.index, required this.isCompleted});

  final int index;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
          ),
          child: Center(
            child:
                isCompleted
                    ? Icon(Icons.check, color: Colors.green)
                    : Styles.title(
                      "${index + 1}",
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
          ),
        ),
      ),
    );
  }
}
