import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/bloc/HomePage/home_page_cubit.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/border_color_extension.dart";
import "package:scale_up/utils/extensions/duration_to_brief_description_extension.dart";

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Your Overall Performance", fontWeight: FontWeight.w600),
        const SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white.borderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16.0,
            children: [AverageTimePerChapter(), ChaptersFinished(), AnswerAccuracyRate()],
          ),
        ),
      ],
    );
  }
}

class AverageTimePerChapter extends StatelessWidget {
  const AverageTimePerChapter({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFCF4242);
    var duration = context.select((HomePageCubit c) => c.state.averageTimePerChapter);
    var (number, unit) = duration.description;

    return StatisticTile(
      highlight: [("$number", 24, isBold: true), (unit, 14, isBold: false)],
      label: "Avg. time",
      color: color,
      icon: Icons.alarm,
    );
  }
}

class ChaptersFinished extends StatelessWidget {
  const ChaptersFinished({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF7F42CF);
    var number = context.select((HomePageCubit c) => c.state.chaptersFinished);

    return StatisticTile(
      highlight: [("$number", 24, isBold: true)], //
      label: "Total Chapters",
      color: color,
    );
  }
}

class AnswerAccuracyRate extends StatelessWidget {
  const AnswerAccuracyRate({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFBA42CF);
    var rate = context.select((HomePageCubit c) => c.state.correctRate);

    return StatisticTile(
      highlight: [("$rate", 24, isBold: true), ("%", 14, isBold: false)],
      label: "Accuracy",
      color: color,
    );
  }
}

class StatisticTile extends StatelessWidget {
  const StatisticTile({
    super.key,
    this.icon,
    required this.highlight,
    required this.label,
    required this.color,
  });

  // final Widget highlight;
  final IconData? icon;
  final List<(String text, int fontSize, {bool isBold})> highlight;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2.0,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: IntrinsicHeight(
            child: Row(
              spacing: 2.0,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (icon case var icon?)
                  Center(child: Icon(icon, color: Colors.grey, size: 16.0)),
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
          ),
        ),
        Text(label, textAlign: TextAlign.center, style: TextStyle(height: 1.5, fontSize: 10)),
      ],
    );
  }
}
