import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile/lesson_tile_colored.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile/lesson_tile_white.dart";

const TextStyle mini = TextStyle(fontSize: 12);

class LessonTile extends StatelessWidget {
  const LessonTile({required this.lesson, this.onTap = _blank, super.key});

  final Lesson lesson;
  final VoidCallback? onTap;

  /// This is a blank function that does nothing.
  ///   It is used as a default value for the onTap parameter.
  ///   This is useful when you want to pass a function that does nothing
  ///   as a default value for a parameter.
  static Never _blank() {
    throw StateError("onTap function is not defined");
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return Provider<Lesson>.value(
      /// This provider is used to pass the properties to the children.
      ///   This is an alternative to prop drilling.
      value: lesson,

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
            decoration: BoxDecoration(borderRadius: borderRadius, color: Colors.white),
            child: InkWell(
              borderRadius: borderRadius,
              onTap:
                  onTap == _blank
                      ? () {
                        context.pushNamed(AppRoutes.lesson, pathParameters: {"id": lesson.id});
                      }
                      : onTap,
              child: IntrinsicWidth(
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [LessonTileWhite(), LessonTileColored()],
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
