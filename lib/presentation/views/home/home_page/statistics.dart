import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/bloc/HomePage/home_page_cubit.dart";
import "package:scale_up/utils/border_color.dart";

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.0,
        children: [
          Expanded(child: AverageTimePerLesson()),
          Expanded(child: AverageTimePerQuestion()),
          Expanded(child: CoursesCompleted()),
        ],
      ),
    );
  }
}

class AverageTimePerLesson extends StatelessWidget {
  const AverageTimePerLesson({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFCF4242);
    var duration = context.select((HomePageCubit c) => c.state.averageTimePerLesson);

    if (_captureDuration(duration) case (var number, var unit)) {
      return StatisticTile(
        highlight: [("$number", 36, isBold: true), (unit, 12, isBold: false)],
        label: "Average time per lesson",
        color: color,
      );
    }

    return const SizedBox.shrink();
  }
}

class AverageTimePerQuestion extends StatelessWidget {
  const AverageTimePerQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFBA42CF);
    var duration = context.select((HomePageCubit c) => c.state.averageTimePerQuestion);

    if (_captureDuration(duration) case (var number, var unit)) {
      return StatisticTile(
        highlight: [("$number", 36, isBold: true), (unit, 12, isBold: false)],
        label: "Average time per question",
        color: color,
      );
    }

    return const SizedBox.shrink();
  }
}

class CoursesCompleted extends StatelessWidget {
  const CoursesCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF7F42CF);
    var number = context.select((HomePageCubit c) => c.state.lessonsCompleted);

    return StatisticTile(
      highlight: [("$number", 36, isBold: true)], //
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
        border: Border.all(color: Colors.white.borderColor),
      ),
      child: Column(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

(int quantity, String unit)? _captureDuration(Duration duration) {
  if (duration.inHours case var hours && > 0) {
    return (hours, "hr");
  }

  if (duration.inMinutes case var minutes && > 0) {
    return (minutes, "min");
  }

  if (duration.inSeconds case var seconds && > 0) {
    return (seconds, "s");
  }

  if (duration.inMilliseconds case var ms && > 0) {
    return (ms, "ms");
  }

  if (duration.inMicroseconds case var us && > 0) {
    return (us, "μs");
  }

  return null;
}
