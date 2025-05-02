import "package:flutter/material.dart";

class TrailingChapterIndex extends StatelessWidget {
  const TrailingChapterIndex({
    super.key,
    required this.isCompleted,
    required this.isNext,
    required this.color,
  });

  final bool isCompleted;
  final bool isNext;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Icon(Icons.arrow_forward_ios_sharp, size: 12.0);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: isNext ? color : Colors.grey.shade100,
        ),
        child: Builder(
          builder: (_) {
            if (isNext) {
              return Text(
                "Start",
                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
              );
            }

            return Text("Locked", style: TextStyle(fontWeight: FontWeight.w400));
          },
        ),
      ),
    );
  }
}
