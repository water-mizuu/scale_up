import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/lesson_tile/latest_lesson_tile.dart";

class LatestLesson extends StatelessWidget {
  const LatestLesson({super.key});

  Lesson? _readLatestLesson(UserDataBloc bloc, LessonsHelper helper) {
    var finishedChapters = bloc.state.finishedChapters;
    var listOfChapters = finishedChapters.entries.map((e) => (e.key, e.value)).toList();
    listOfChapters.sort((a, b) => -a.$2.difference(b.$2).inMilliseconds);
    if (listOfChapters.isEmpty) return null;

    var (chapterId, finishedDate) = listOfChapters.first;
    var parseResult = ChapterType.tryParse(chapterId);
    if (parseResult == null) return null;

    var (lessonId, _, _) = parseResult;
    var lesson = helper.getLesson(lessonId);
    if (lesson == null) return null;

    return lesson;
  }

  @override
  Widget build(BuildContext context) {
    var helper = context.read<LessonsHelper>();
    var lesson = context.select((UserDataBloc b) => (_readLatestLesson(b, helper)));
    if (lesson == null) {
      return SizedBox.shrink();
    }

    return LatestLessonTile(lesson: lesson);
  }
}
