import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/border_color_extension.dart";
import "package:scale_up/utils/extensions/title_case_extension.dart";
import "package:scale_up/utils/widgets/tap_scale.dart";

class OngoingLessonTile extends StatelessWidget {
  const OngoingLessonTile({
    super.key,
    required this.lesson,
    this.onTap = _blank,
    this.isSmall = false,
  });

  final Lesson lesson;
  final VoidCallback? onTap;
  final bool isSmall;

  /// This is a blank function that does nothing.
  ///   It is used as a default value for the onTap parameter.
  ///   This is useful when you want to pass a function that does nothing
  ///   as a default value for a parameter.
  static Never _blank() {
    throw StateError("onTap function is not defined");
  }

  ({Color foreground, Color background, Color progressBackground}) getColors() {
    var lessonColor = lesson.color;

    var foregroundColor = lessonColor;
    var backgroundColor = Colors.white;
    var progressBackgroundColor = Colors.grey;

    return (
      foreground: foregroundColor,
      background: backgroundColor,
      progressBackground: progressBackgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    var helper = context.read<LessonsHelper>();
    var chaptersDone = context.select(
      (UserDataBloc b) =>
          b.state.finishedChapters.keys.where((e) => e.startsWith(lesson.id)).length,
    );

    var totalChapters = lesson.learnChapters.length + lesson.practiceChapters.length;
    var progress = chaptersDone / totalChapters;

    var (:foreground, :background, :progressBackground) = getColors();

    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle(lesson.name, fontSize: 16, fontWeight: FontWeight.w600),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Styles.subtitle(
                "Units: ${lesson.units.map((u) => helper.getUnit(lesson.unitsType, u)!).map((u) => u.display ?? u.id.toTitleCase()).join(", ")}",
                fontSize: 10,
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              height: 36.0,
              decoration: BoxDecoration(
                color: HSLColor.fromColor(foreground).withLightness(0.5).toColor(),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Center(child: Icon(Icons.keyboard_arrow_right, color: Colors.white)),
              ),
            ),
          ],
        ),

        Text(
          "$chaptersDone / $totalChapters chapters",
          style: TextStyle(fontSize: 12, color: foreground),
        ),

        const SizedBox(height: 4.0),
        Row(
          children: [
            Expanded(
              child: FAProgressBar(
                size: 4,
                currentValue: (progress * 100).floorToDouble(),
                borderRadius: BorderRadius.circular(24.0),
                progressColor: foreground,
                backgroundColor: progressBackground,
                animatedDuration: const Duration(milliseconds: 150),
              ),
            ),
            Expanded(child: const SizedBox()),
          ],
        ),
      ],
    );

    return TapScale(
      child: GestureDetector(
        onTap: () {
          if (onTap == _blank) {
            return () {
              HapticFeedback.selectionClick();

              context.pushNamed(AppRoutes.lesson, pathParameters: {"id": lesson.id});
            };
          }

          return onTap;
        }(),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [background, background.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white.borderColor),
          ),
          child: child,
        ),
      ),
    );
  }
}
