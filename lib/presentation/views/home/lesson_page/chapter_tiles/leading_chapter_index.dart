import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";

class LeadingChapterIndex extends StatelessWidget {
  const LeadingChapterIndex({
    super.key,
    required this.index,
    required this.color,
    required this.isCompleted,
    required this.isNext,
  });

  final int index;
  final Color color;
  final bool isCompleted;
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: () {
              if (isCompleted) {
                return Colors.green.shade50;
              }
              if (isNext) {
                return color.backgroundColor;
              }

              return Colors.grey.shade100;
            }(),
          ),
          child: Center(
            child: Builder(
              builder: (_) {
                if (isCompleted) {
                  return Icon(Icons.check, color: Colors.green);
                }
                return Styles.title(
                  "${index + 1}",
                  color: isNext ? color : Colors.grey,
                  fontWeight: FontWeight.w400,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
