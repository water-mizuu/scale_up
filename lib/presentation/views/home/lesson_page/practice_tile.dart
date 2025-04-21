import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/practice_chapter.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/lesson_page/chapter_index.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class PracticeTile extends StatelessWidget {
  const PracticeTile({super.key, required this.index, required this.chapter});

  final int index;
  final PracticeChapter chapter;

  @override
  Widget build(BuildContext context) {
    var lessonId = context.read<LessonPageCubit>().state.lesson.id;
    var key = "$lessonId:p:$index";
    var isComplete = context.select(
      (UserDataBloc bloc) => bloc.state.finishedChapters.contains(key),
    );

    return Material(
      elevation: 12.0,
      borderRadius: BorderRadius.circular(8.0),
      shadowColor: Colors.black.withValues(alpha: 0.05),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        leading: ChapterIndex(index: index, isCompleted: isComplete),
        title: Styles.body(chapter.name, fontSize: 14),
        subtitle: Styles.body("${chapter.questionCount} questions", color: Colors.grey),
        onTap:
        // isComplete
        // ? null
        // :
        () {
          context.pushNamed(
            AppRoutes.practice,
            pathParameters: {"id": lessonId, "chapterIndex": "$index"},
          );
        },
      ),
    );
  }
}
