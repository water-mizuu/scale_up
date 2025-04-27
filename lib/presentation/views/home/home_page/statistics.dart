import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16.0,
      children: [
        Flexible(child: AverageTimePerLesson()),
        Flexible(child: AverageTimePerQuestion()),
        Flexible(child: CoursesCompleted()),
      ],
    );
  }
}

class AverageTimePerLesson extends StatelessWidget {
  const AverageTimePerLesson({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFCF4242);

    return StatisticTile(
      highlight: [("2", 36, isBold: true), ("min", 12, isBold: false)],
      label: "Average time per lesson",
      color: color,
    );
  }
}

class AverageTimePerQuestion extends StatelessWidget {
  const AverageTimePerQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFBA42CF);

    return StatisticTile(
      highlight: [("10", 36, isBold: true), ("sec", 12, isBold: false)],
      label: "Average time per question",
      color: color,
    );
  }
}

class CoursesCompleted extends StatelessWidget {
  const CoursesCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF7F42CF);

    return StatisticTile(
      highlight: [("5", 36, isBold: true)], //
      label: "Lessons completed",
      color: color,
    );
  }
}

class StatisticTile extends StatelessWidget {
  const StatisticTile({
    super.key,
    required this.highlight,
    required this.label,
    required this.color,
  });

  // final Widget highlight;
  final List<(String text, int fontSize, {bool isBold})> highlight;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0) + EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: defaultBoxShadow,
      ),
      child: Column(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 2.0,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var (text, size, :isBold) in highlight)
                Text(
                  text,
                  style: TextStyle(
                    fontSize: size.toDouble(),
                    fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                    color: color,
                    height: 1.2,
                  ),
                ),
            ],
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.5, color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
