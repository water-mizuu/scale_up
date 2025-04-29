import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/border_color.dart";
import "package:scale_up/utils/title_case.dart";

class NewerLessonTile extends StatelessWidget {
  const NewerLessonTile({
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

  @override
  Widget build(BuildContext context) {
    var chaptersDone =
        context
            .read<UserDataBloc>()
            .state
            .finishedChapters
            .keys
            .where((e) => e.startsWith(lesson.id))
            .length;

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
              Text("Not yet", style: TextStyle(fontSize: 12, color: foreground)),
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
            "Units: ${lesson.units.map((s) => s.toTitleCase()).join(", ")}",
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
              Text("Not yet", style: TextStyle(fontSize: 12, color: foreground)),
            ],
          ),

          const SizedBox(height: 4.0),
          FAProgressBar(
            size: 16,
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
