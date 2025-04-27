import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/title_case.dart";

class NewerLessonTile extends StatelessWidget {
  const NewerLessonTile({
    super.key,
    required this.lesson,
    this.onTap = _blank,
    this.isHighlighted = false,
  });

  final Lesson lesson;
  final VoidCallback? onTap;
  final bool isHighlighted;

  /// This is a blank function that does nothing.
  ///   It is used as a default value for the onTap parameter.
  ///   This is useful when you want to pass a function that does nothing
  ///   as a default value for a parameter.
  static Never _blank() {
    throw StateError("onTap function is not defined");
  }

  @override
  Widget build(BuildContext context) {
    var chaptersDone =
        context
            .read<UserDataBloc>()
            .state
            .finishedChapters
            .where((e) => e.startsWith(lesson.id))
            .length;

    var totalChapters = lesson.learnChapters.length + lesson.practiceChapters.length;
    var progress = chaptersDone / totalChapters;

    var foregroundColor = isHighlighted ? Colors.white : lesson.color;
    var backgroundColor = isHighlighted ? lesson.color : Colors.white;
    var progressBackgroundColor =
        isHighlighted
            ? lesson.hslColor.withLightness(lesson.hslColor.lightness * 0.8).toColor()
            : Colors.grey;

    return GestureDetector(
      onTap:
          onTap == _blank
              ? () {
                context.pushNamed(AppRoutes.lesson, pathParameters: {"id": lesson.id});
              }
              : onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor, backgroundColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: defaultBoxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Styles.subtitle(lesson.name, fontSize: 20, color: foregroundColor),
            Styles.subtitle(
              "Units: ${lesson.units.map((s) => s.toTitleCase()).join(", ")}",
              fontSize: 12,
              color: foregroundColor,
            ),

            const SizedBox(height: 16.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$chaptersDone / $totalChapters chapters done",
                  style: TextStyle(fontSize: 12, color: foregroundColor),
                ),
                Text("Not yet", style: TextStyle(fontSize: 12, color: foregroundColor)),
              ],
            ),

            const SizedBox(height: 4.0),
            FAProgressBar(
              size: 16,
              currentValue: (progress * 100).floorToDouble(),
              borderRadius: BorderRadius.circular(24.0),
              progressColor: foregroundColor,
              backgroundColor: progressBackgroundColor,
              animatedDuration: const Duration(milliseconds: 150),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallNewerLessonTile extends StatelessWidget {
  const SmallNewerLessonTile({
    super.key,
    required this.lesson,
    this.onTap = _blank,
    this.isHighlighted = false,
  });

  final Lesson lesson;
  final VoidCallback? onTap;
  final bool isHighlighted;

  /// This is a blank function that does nothing.
  ///   It is used as a default value for the onTap parameter.
  ///   This is useful when you want to pass a function that does nothing
  ///   as a default value for a parameter.
  static Never _blank() {
    throw StateError("onTap function is not defined");
  }

  @override
  Widget build(BuildContext context) {
    var chaptersDone =
        context
            .read<UserDataBloc>()
            .state
            .finishedChapters
            .where((e) => e.startsWith(lesson.id))
            .length;

    var totalChapters = lesson.learnChapters.length + lesson.practiceChapters.length;
    var progress = chaptersDone / totalChapters;

    var foregroundColor = isHighlighted ? Colors.white : lesson.color;
    var backgroundColor = isHighlighted ? lesson.color : Colors.white;
    var progressBackgroundColor =
        isHighlighted
            ? lesson.hslColor.withLightness(lesson.hslColor.lightness * 0.8).toColor()
            : Colors.grey;

    return GestureDetector(
      onTap:
          onTap == _blank
              ? () {
                context.pushNamed(AppRoutes.lesson, pathParameters: {"id": lesson.id});
              }
              : onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor, backgroundColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: defaultBoxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Styles.subtitle(lesson.name, fontSize: 20, color: foregroundColor),
            Styles.subtitle(
              "Units: ${lesson.units.map((s) => s.toTitleCase()).join(", ")}",
              fontSize: 12,
              color: foregroundColor,
            ),

            const SizedBox(height: 16.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$chaptersDone / $totalChapters",
                  style: TextStyle(fontSize: 12, color: foregroundColor),
                ),
                Text("Not yet", style: TextStyle(fontSize: 12, color: foregroundColor)),
              ],
            ),

            const SizedBox(height: 4.0),
            FAProgressBar(
              size: 16,
              currentValue: (progress * 100).floorToDouble(),
              borderRadius: BorderRadius.circular(24.0),
              progressColor: foregroundColor,
              backgroundColor: progressBackgroundColor,
              animatedDuration: const Duration(milliseconds: 150),
            ),
          ],
        ),
      ),
    );
  }
}
