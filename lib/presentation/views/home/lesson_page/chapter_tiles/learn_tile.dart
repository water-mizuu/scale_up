import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/models/learn_chapter.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/presentation/bloc/lesson_page/lesson_page_bloc.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/lesson_page/"
    "chapter_tiles/leading_chapter_index.dart";
import "package:scale_up/presentation/views/home/lesson_page/"
    "chapter_tiles/trailing_chapter_index.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/border_color_extension.dart";
import "package:scale_up/utils/widgets/tap_scale.dart";

class LearnTile extends StatelessWidget {
  const LearnTile({super.key, required this.chapterIndex, required this.chapter});

  final int chapterIndex;
  final LearnChapter chapter;

  @override
  Widget build(BuildContext context) {
    var lesson = context.read<LessonPageCubit>().state.lesson;
    var lessonId = lesson.id;
    var key = ChapterType.learn.stringify(lessonId, chapterIndex);
    var isComplete = context.select(
      (UserDataBloc b) => b.state.finishedChapters.containsKey(key),
    );

    var previousChapter =
        chapterIndex > 0
            ? context.read<LessonPageCubit>().state.lesson.learnChapters[chapterIndex - 1]
            : null;

    late var isPreviousComplete = context
        .read<UserDataBloc>() //
        .state
        .finishedChapters
        .containsKey(ChapterType.learn.stringify(lessonId, chapterIndex - 1));

    var isNext = previousChapter == null ? true : isPreviousComplete;

    return TapScale(
      child: Material(
        child: ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white.borderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
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
            color: (isComplete || isNext) ? Colors.black : Colors.grey,
          ),
          onTap: () async {
            HapticFeedback.selectionClick();

            var shouldPush = true;
            var isReview = false;

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
              isReview = userWantsToReview;
            } else {
              late var previousChapter =
                  chapterIndex > 0
                      ? context.read<LessonPageCubit>().state.lesson.learnChapters[chapterIndex -
                          1]
                      : null;

              late var isPreviousComplete = context
                  .read<UserDataBloc>()
                  .state
                  .finishedChapters
                  .containsKey(ChapterType.learn.stringify(lessonId, chapterIndex - 1));

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
                      "You haven't completed the previous chapter yet.",
                  cancelButtonText: "No",
                  confirmButtonText: "Yes",
                );

                shouldPush = userWantsToSkip;
              }
            }

            if (shouldPush && context.mounted) {
              context.pushNamed(
                AppRoutes.learn,
                pathParameters: {
                  "id": lessonId,
                  "chapterIndex": "$chapterIndex",
                  "isReview": "$isReview",
                },
              );
            }
          },
        ),
      ),
    );
  }
}
