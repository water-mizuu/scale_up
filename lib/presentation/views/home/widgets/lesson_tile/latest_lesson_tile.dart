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
import "package:scale_up/utils/extensions/duration_to_brief_description_extension.dart";
import "package:scale_up/utils/extensions/title_case_extension.dart";
import "package:scale_up/utils/widgets/tap_scale.dart";

class LatestLessonTile extends StatelessWidget {
  const LatestLessonTile({
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

  ({Color foreground, Color background, Color progressBackground}) _getColors() {
    var lessonColor = lesson.color;
    var hslColor = lesson.hslColor;

    var foregroundColor = Colors.white;
    var backgroundColor = lessonColor;
    var progressBackgroundColor =
        hslColor
            .withSaturation(hslColor.saturation * 0.5)
            .withLightness(hslColor.lightness * 0.8)
            .toColor();

    return (
      foreground: foregroundColor,
      background: backgroundColor,
      progressBackground: progressBackgroundColor,
    );
  }

  void _goToLesson(BuildContext context) {
    HapticFeedback.selectionClick();

    context.pushNamed(AppRoutes.lesson, pathParameters: {"id": lesson.id});
  }

  (int finishedChapterCount, Duration? lastStudied) _readUserDataBloc(UserDataBloc b) {
    var entries = b.state.finishedChapters.entries.where((e) => e.key.startsWith(lesson.id));

    var finishedChapterCount = entries.length;
    var datesOfCompletion =
        entries
            .map((e) => e.value)
            .toList() //
          ..sort((a, b) => -a.compareTo(b));

    Duration? lastStudied;
    var lastDateOfCompletion = datesOfCompletion.firstOrNull;
    if (lastDateOfCompletion case var lastDateOfCompletion?) {
      lastStudied = DateTime.now().difference(lastDateOfCompletion);
    }

    return (finishedChapterCount, lastStudied);
  }

  @override
  Widget build(BuildContext context) {
    var helper = context.read<LessonsHelper>();
    var (chaptersDone, lastStudied) = context.select(_readUserDataBloc);
    var progress = chaptersDone / lesson.chapterCount;
    var (:foreground, :background, :progressBackground) = _getColors();

    var unitDisplay = lesson.units
        .map((u) => helper.getUnit(lesson.unitsType, u)!)
        .map((u) => u.display ?? u.id.toTitleCase())
        .join(", ");

    return TapScale(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _goToLesson(context),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: IgnorePointer(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Styles.subtitle(lesson.name, fontSize: 20, color: foreground),
                  Styles.subtitle("Units: $unitDisplay", fontSize: 12, color: foreground),

                  const SizedBox(height: 16.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$chaptersDone/${lesson.chapterCount} chapters done",
                        style: TextStyle(fontSize: 12, color: foreground),
                      ),

                      if (lastStudied?.description case (var amount, var unit))
                        Text("$amount $unit", style: TextStyle(fontSize: 12, color: foreground)),
                    ],
                  ),

                  const SizedBox(height: 8.0),
                  FAProgressBar(
                    size: 8,
                    currentValue: progress * 100,
                    borderRadius: BorderRadius.circular(24.0),
                    progressColor: foreground,
                    backgroundColor: progressBackground,
                    animatedDuration: Duration.zero,
                  ),
                  const SizedBox(height: 12.0),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: lesson.color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow_outlined),
                        const Text("Continue Learning"),
                      ],
                    ),
                    onPressed: () => _goToLesson(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
