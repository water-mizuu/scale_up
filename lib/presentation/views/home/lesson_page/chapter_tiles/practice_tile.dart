import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/models/practice_chapter.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/presentation/bloc/lesson_page/lesson_page_bloc.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/lesson_page/"
    "chapter_tiles/leading_chapter_index.dart";
import "package:scale_up/presentation/views/home/lesson_page/chapter_tiles/trailing_chapter_index.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/widgets/tap_scale.dart";

class PracticeTile extends StatelessWidget {
  const PracticeTile({super.key, required this.chapterIndex, required this.chapter});

  final int chapterIndex;
  final PracticeChapter chapter;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LessonPageCubit>();
    var lesson = cubit.state.lesson;
    var lessonId = lesson.id;
    var key = ChapterType.practice.stringify(lessonId, chapterIndex);
    var isComplete = context.select(
      (UserDataBloc bloc) => bloc.state.finishedChapters.containsKey(key),
    );

    var previousChapter =
        chapterIndex > 0
            ? context.read<LessonPageCubit>().state.lesson.learnChapters[chapterIndex - 1]
            : null;

    var isPreviousComplete = context
        .read<UserDataBloc>() //
        .state
        .finishedChapters
        .containsKey(ChapterType.practice.stringify(lessonId, chapterIndex - 1));

    var isNext = previousChapter == null ? true : isPreviousComplete;

    return TapScale(
      child: Material(
        child: ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          leading: LeadingChapterIndex(
            index: chapterIndex,
            isCompleted: isComplete,
            isNext: isNext,
            color: lesson.color,
          ),
          trailing: TrailingChapterIndex(
            isCompleted: isComplete,
            isNext: isNext,
            color: lesson.color,
          ),
          title: Styles.body(
            chapter.name,
            fontSize: 14,
            color: isNext || isComplete ? Colors.black : Colors.grey,
          ),
          subtitle: Styles.body("${chapter.questionCount} questions", color: Colors.grey),
          onTap: () async {
            HapticFeedback.selectionClick();

            var shouldPush = false;
            if (isComplete) {
              // Previous chapter is not complete, ask for confirmation

              var userWantsToReview = await context.showConfirmationDialog(
                title: "Reviewing?",
                message:
                    "You have already finished this chapter. "
                    "Do you want to review it instead?",
                cancelButtonText: "No",
                confirmButtonText: "Review",
              );

              shouldPush = userWantsToReview;
            } else {
              late var previousChapter = switch (chapterIndex) {
                0 => null,
                _ => cubit.state.lesson.practiceChapters[chapterIndex - 1],
              };

              late var isPreviousComplete = context
                  .read<UserDataBloc>()
                  .state
                  .finishedChapters
                  .containsKey(ChapterType.practice.stringify(lessonId, chapterIndex - 1));

              if (previousChapter == null) {
                // No previous chapter, so we can push without confirmation
                shouldPush = true;
              } else if (isPreviousComplete) {
                // Previous chapter is complete, so we can push without confirmation
                shouldPush = true;
              } else {
                // Previous chapter is not complete, ask for confirmation

                var userWantsToSkip = await context.showConfirmationDialog(
                  title: "Skipping Ahead?",
                  message:
                      "Are you sure you want to start this chapter? "
                      "These chapters are structured to increse in difficulty. "
                      "You may find this chapter difficult if you haven't "
                      "completed the previous one.",
                  cancelButtonText: "No, thanks",
                  confirmButtonText: "Yes",
                );

                shouldPush = userWantsToSkip;
              }
            }

            if (context.mounted && shouldPush) {
              context.pushNamed(
                AppRoutes.practice,
                pathParameters: {"id": lessonId, "chapterIndex": "$chapterIndex"},
              );
            }
          },
        ),
      ),
    );
  }
}
