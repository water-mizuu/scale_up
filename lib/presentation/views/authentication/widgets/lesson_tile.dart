import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/views/authentication/widgets/"
    "lesson_tile_colored.lesson_tile.dart";
import "package:scale_up/presentation/views/authentication/widgets/"
    "lesson_tile_white.lesson_tile.dart";

const TextStyle mini = TextStyle(fontSize: 12);
typedef LessonTileProps = ({
  String label,
  String? sublabel,
  IconData icon,
  int questionsDone,
  int questionsTotal,
  Color baseColor,
});

class LessonTile extends StatelessWidget {
  const LessonTile({
    required this.label,
    this.sublabel,
    required this.questionsDone,
    required this.questionsTotal,
    required this.icon,
    required this.baseColor,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final int questionsDone;
  final int questionsTotal;
  final String label;
  final String? sublabel;
  final Color baseColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return Provider<LessonTileProps>.value(
      /// This provider is used to pass the properties to the children.
      ///   This is an alternative to prop drilling.
      value: (
        label: label,
        sublabel: sublabel,
        icon: icon,
        questionsDone: questionsDone,
        questionsTotal: questionsTotal,
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
                      LessonTileWhite(),
                      LessonTileColored(),
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
