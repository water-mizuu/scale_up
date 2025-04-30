import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/border_color.dart";
import "package:scale_up/utils/duration_to_brief_description_extension.dart";
import "package:scale_up/utils/title_case.dart";

class LessonTile extends StatelessWidget {
  const LessonTile({
    super.key,
    required this.lesson,
    this.onTap = _blank,
    this.isHighlighted = false,
    this.isSmall = false,
  });

  final Lesson lesson;
  final VoidCallback? onTap;
  final bool isHighlighted;
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
    var hslColor = lesson.hslColor;

    var foregroundColor = isHighlighted ? Colors.white : lessonColor;
    var backgroundColor = isHighlighted ? lessonColor : Colors.white;
    var progressBackgroundColor =
        isHighlighted //
            ? hslColor.withLightness(hslColor.lightness * 0.8).toColor()
            : Colors.grey;

    return (
      foreground: foregroundColor,
      background: backgroundColor,
      progressBackground: progressBackgroundColor,
    );
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

    var totalChapters = lesson.learnChapters.length + lesson.practiceChapters.length;
    var progress = chaptersDone / totalChapters;

    var (:foreground, :background, :progressBackground) = getColors();

    Widget child;
    if (isSmall) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Styles.subtitle(lesson.name, fontSize: 20, color: foreground),
          const SizedBox(height: 8.0),

          Row(
            children: [
              Text(
                "$chaptersDone / $totalChapters",
                style: TextStyle(fontSize: 12, color: foreground),
              ),

              const SizedBox(width: 24.0),
              if (lastStudied?.description case (var amount, var unit))
                Text("$amount $unit ago", style: TextStyle(fontSize: 12, color: foreground)),
            ],
          ),
          const SizedBox(height: 4.0),
          FAProgressBar(
            size: 4,
            currentValue: (progress * 100).floorToDouble(),
            borderRadius: BorderRadius.circular(24.0),
            progressColor: foreground,
            backgroundColor: progressBackground,
            animatedDuration: const Duration(milliseconds: 150),
          ),
        ],
      );
    } else {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Styles.subtitle(lesson.name, fontSize: 20, color: foreground),
          Styles.subtitle(
            "Units: ${lesson.units.map((u) => helper.getUnit(u)!).map((u) => u.display ?? u.id.toTitleCase()).join(", ")}",
            fontSize: 12,
            color: foreground,
          ),

          const SizedBox(height: 16.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$chaptersDone / $totalChapters chapters done",
                style: TextStyle(fontSize: 12, color: foreground),
              ),
              if (lastStudied?.description case (var amount, var unit))
                Text("$amount $unit ago", style: TextStyle(fontSize: 12, color: foreground)),
            ],
          ),

          if (isHighlighted) const SizedBox(height: 8.0) else const SizedBox(height: 4.0),
          FAProgressBar(
            size: isHighlighted ? 12 : 4,
            currentValue: (progress * 100).floorToDouble(),
            borderRadius: BorderRadius.circular(24.0),
            progressColor: foreground,
            backgroundColor: progressBackground,
            animatedDuration: const Duration(milliseconds: 150),
          ),
        ],
      );
    }

    return GestureDetector(
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
    );
  }
}
