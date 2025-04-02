import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile_colored.lesson_tile.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile_white.lesson_tile.dart";

const TextStyle mini = TextStyle(fontSize: 12);

class LessonTile extends StatelessWidget {
  const LessonTile({
    required this.lesson,
    super.key,
  });

  final Lesson lesson;

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
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.white,
            ),
            child: InkWell(
              borderRadius: borderRadius,
              onTap: () {
                context.goNamed(
                  AppRoutes.lesson,
                  pathParameters: {"id": lesson.id},
                );
              },
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
