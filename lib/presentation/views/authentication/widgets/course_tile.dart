import 'package:flutter/material.dart';
import 'package:scale_up/presentation/widgets/styles.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({
    required this.label,
    this.sublabel,
    required this.icon,
    required this.progressBarValue,
    required this.baseColor,
    super.key,
  });

  final IconData icon;
  final String label;
  final String? sublabel;
  final double progressBarValue;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    /// Ink is used here to basically make the shadow persistent.
    return Ink(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),

      /// This material widget makes sure that the ink doesn't overflow
      ///   through clipping like in scroll views.
      child: Material(
        /// The first ink handles the background color.
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {},
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CourseTileWhite(
                      label: label,
                      sublabel: sublabel,
                      progressBarValue: progressBarValue,
                      baseColor: baseColor,
                    ),
                    CourseTileColored(baseColor: baseColor, icon: icon),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CourseTileWhite extends StatelessWidget {
  const CourseTileWhite({
    super.key,
    required this.label,
    required this.sublabel,
    required this.progressBarValue,
    required this.baseColor,
  });

  final String label;
  final String? sublabel;
  final double progressBarValue;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          spacing: 2.0,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80,
                maxWidth: 130,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label),
                  Text(
                    sublabel ?? "",
                    style: Styles.caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CourseProgression(
                  progressBarValue: progressBarValue,
                  baseColor: baseColor,
                ),
                Text("${(progressBarValue * 100).round()}%"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CourseTileColored extends StatelessWidget {
  const CourseTileColored({
    super.key,
    required this.baseColor,
    required this.icon,
  });

  final Color baseColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [
            baseColor,
            baseColor.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(icon, color: Colors.white, size: 18.0),
      ),
    );
  }
}

class CourseProgression extends StatelessWidget {
  const CourseProgression({
    super.key,
    required this.progressBarValue,
    required this.baseColor,
  });

  final double progressBarValue;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(
        padding: EdgeInsets.all(0.0),
        value: progressBarValue,
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(baseColor),
      ),
    );
  }
}
