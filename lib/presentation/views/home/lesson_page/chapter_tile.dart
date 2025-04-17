import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/chapter.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/lesson_page/chapter_index.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class ChapterTile extends StatelessWidget {
  const ChapterTile({super.key, required this.index, required this.chapter});

  final int index;
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    var lessonId = context.read<Lesson>().id;
    var key = "$lessonId:$index";
    var isComplete = context.select<UserDataBloc, bool>(
      (bloc) => bloc.state.finishedChapters.contains(key),
    );

    return Material(
      elevation: 12.0,
      borderRadius: BorderRadius.circular(25.0),
      shadowColor: Colors.black.withValues(alpha: 0.3),
      child: ListTile(
        leading: ChapterIndex(index: index, isCompleted: isComplete),
        title: Styles.body(chapter.name, fontSize: 14),
        subtitle: Styles.body("${chapter.questionCount} questions", color: Colors.grey),
        onTap:
        // isComplete
        //     ? null
        //     :
        () {
          context.pushNamed(
            AppRoutes.chapter,
            pathParameters: {"id": lessonId, "chapterIndex": "$index"},
          );
        },
        tileColor: Colors.white,
      ),
    );
  }
}
