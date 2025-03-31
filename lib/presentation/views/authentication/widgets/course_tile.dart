import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

const TextStyle mini = TextStyle(fontSize: 12);
typedef _CourseTileProps = ({
  String label,
  String? sublabel,
  IconData icon,
  int questionsDone,
  int questionsTotal,
  double progressBarValue,
  Color baseColor,
});

class CourseTile extends StatelessWidget {
  const CourseTile({
    required this.label,
    this.sublabel,
    required this.questionsDone,
    required this.questionsTotal,
    required this.icon,
    required this.progressBarValue,
    required this.baseColor,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final int questionsDone;
  final int questionsTotal;
  final String label;
  final String? sublabel;
  final double progressBarValue;
  final Color baseColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return Provider<_CourseTileProps>.value(
      /// This provider is used to pass the properties to the children.
      ///   This is an alternative to prop drilling.
      value: (
        label: label,
        sublabel: sublabel,
        icon: icon,
        questionsDone: questionsDone,
        questionsTotal: questionsTotal,
        progressBarValue: progressBarValue,
        baseColor: baseColor,
      ),

      /// Ink is used here to basically make the shadow persistent.
      child: Ink(
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
              onTap: onTap,
              child: IntrinsicWidth(
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CourseTileWhite(),
                      CourseTileColored(),
                    ],
                  ),
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
  const CourseTileWhite({super.key});

  // Length
  // Unit 1
  //
  // SI Units (m)

  @override
  Widget build(BuildContext context) {
    var _CourseTileProps(
      :label,
      :sublabel,
      :questionsDone,
      :questionsTotal,
      :progressBarValue,
      :baseColor,
    ) = context.read<_CourseTileProps>();

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          spacing: 20.0,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 110,
                maxWidth: 160,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$questionsDone/$questionsTotal", style: mini),
                Row(
                  spacing: 4.0,
                  children: [
                    CourseProgression(
                      progressBarValue: progressBarValue,
                      baseColor: baseColor,
                    ),
                    Text("${(progressBarValue * 100).round()}%", style: mini)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CourseTileColored extends StatelessWidget {
  const CourseTileColored({super.key});

  @override
  Widget build(BuildContext context) {
    var _CourseTileProps(:baseColor, :icon) = context.read();

    return Container(
      padding: const EdgeInsets.all(8.0) + const EdgeInsets.symmetric(horizontal: 4.0),
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
