import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/views/home/lesson_page/chapter_tiles/learn_tile.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/widgets/tap_scale.dart";

class LessonLearnChapters extends StatelessWidget {
  const LessonLearnChapters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Learn", fontWeight: FontWeight.w600),
        Column(
          spacing: 8.0,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var (index, chapter)
                in context.read<LessonPageCubit>().state.lesson.learnChapters.indexed)
              LearnTile(chapterIndex: index, chapter: chapter)
                  .animate() //
                  .then(delay: (index * 100).milliseconds)
                  .slideY(duration: 250.ms, begin: 0.1, end: 0.0)
                  .fadeIn(duration: 250.ms),
          ],
        ),
      ],
    );
  }
}
