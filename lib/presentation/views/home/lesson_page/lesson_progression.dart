import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:scale_up/data/models/learn_chapter.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/practice_chapter.dart";
import "package:scale_up/presentation/bloc/lesson_page/lesson_page_bloc.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/string_to_icon.dart";

class LessonProgression extends HookWidget {
  const LessonProgression({super.key});

  @override
  Widget build(BuildContext context) {
    // Reading the lesson data
    var lesson = context.read<LessonPageCubit>().state.lesson;
    var Lesson(:id, :units, :practiceChapters, :learnChapters, :color, :hslColor, :icon) = lesson;

    var progressData = _calculateProgress(id, practiceChapters, learnChapters);
    var backgroundColor = _generateBackgroundColor(hslColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitle(),
        const SizedBox(height: 8.0),
        _buildProgressContainer(
          icon: icon,
          color: color,
          progressData: progressData,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }

  _ProgressData _calculateProgress(
    String lessonId,
    List<PracticeChapter> practiceChapters,
    List<LearnChapter> learnChapters,
  ) {
    final context = useContext();
    final completedChapters = context.select((UserDataBloc bloc) {
      return bloc.state.finishedChapters.keys.where((n) => n.startsWith(lessonId)).length;
    });

    final totalChapters = practiceChapters.length + learnChapters.length;
    final progressValue = totalChapters == 0 ? 0.0 : completedChapters / totalChapters;

    return _ProgressData(
      completedChapters: completedChapters,
      totalChapters: totalChapters,
      progressValue: progressValue,
    );
  }

  Color _generateBackgroundColor(HSLColor hslColor) {
    return hslColor
        .withLightness((hslColor.lightness + 0.25).clamp(0, 1))
        .withSaturation(hslColor.saturation / 4)
        .toColor();
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Styles.subtitle("Progress", fontWeight: FontWeight.w600),
        const SizedBox(width: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Styles.caption("Track your journey", color: Colors.blue.shade800, fontSize: 11),
        ),
        const Spacer(),
        Icon(Icons.insights_rounded, size: 16, color: Colors.grey.shade600),
      ],
    );
  }

  Widget _buildProgressContainer({
    required String icon,
    required Color color,
    required _ProgressData progressData,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildIconContainer(icon, color),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildProgressSection(
                color: color,
                progressData: progressData,
                backgroundColor: backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(String icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12.0)),
      child: Icon(stringToIcon[icon]!, color: Colors.white, size: 32.0),
    );
  }

  Widget _buildProgressSection({
    required Color color,
    required _ProgressData progressData,
    required Color backgroundColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: FAProgressBar(
                size: 10.0,
                maxValue: 100,
                currentValue: progressData.progressValue * 100,
                progressColor: color,
                backgroundColor: backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
                animatedDuration: const Duration(milliseconds: 150),
                direction: Axis.horizontal,
                verticalDirection: VerticalDirection.up,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Styles.body(
              "${progressData.completedChapters} / ${progressData.totalChapters} chapters",
              color: color,
              fontWeight: FontWeight.w600,
            ),
            Styles.body(
              progressData.totalChapters - progressData.completedChapters > 0
                  ? "${progressData.totalChapters - progressData.completedChapters} remaining"
                  : "Completed!",
              color:
                  progressData.totalChapters - progressData.completedChapters > 0
                      ? Colors.grey.shade600
                      : Colors.green,
              fontSize: 12,
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressData {
  final int completedChapters;
  final int totalChapters;
  final double progressValue;

  _ProgressData({
    required this.completedChapters,
    required this.totalChapters,
    required this.progressValue,
  });
}
