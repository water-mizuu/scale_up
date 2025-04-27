import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/HomePage/home_page_state.dart";

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({
    required Set<String> finishedChaptersString,
    required LessonsHelper lessonsHelper,
  }) : _lessonsHelper = lessonsHelper,
       super(HomePageState()) {
    Future.delayed(Duration.zero, () => updateFinishedChaptersString(finishedChaptersString));
  }

  final LessonsHelper _lessonsHelper;

  void updateFinishedChaptersString(Set<String> finishedChaptersString) async {
    var allLessons = _lessonsHelper.lessons;
    var finishedChaptersLessonIds =
        finishedChaptersString
            // The format is "$lessonId:$index"
            .map((s) => s.split(":"))
            // We take only the lesson id.
            .map((s) => s[0]) //
            .toList();

    if (kDebugMode) {
      print(finishedChaptersString);
    }

    var count = {for (var lessonId in finishedChaptersLessonIds) lessonId: 0};
    for (var key in finishedChaptersLessonIds) {
      count[key] = count[key]! + 1;
    }

    double progression(Lesson lesson) =>
        count[lesson.id] != null
            ? count[lesson.id]! / (lesson.practiceChapters.length + lesson.learnChapters.length)
            : 0;

    var ongoingLessons = [
      for (var lesson in allLessons)
        if (count[lesson.id] case var chapterCount?
            when 0 < chapterCount && chapterCount < lesson.chapterCount)
          lesson,
    ]..sort((a, b) => progression(b).compareTo(progression(a)));

    var newLessons = [
      for (var lesson in allLessons)
        if (count[lesson.id] case null || 0) lesson,
    ];

    var finishedLessons = [
      for (var lesson in allLessons)
        if (count[lesson.id] case var chapterCount? when chapterCount >= lesson.chapterCount)
          lesson,
    ];

    emit(
      state.copyWith(
        ongoingLessons: ongoingLessons,
        newLessons: newLessons,
        finishedLessons: finishedLessons,
      ),
    );
  }
}
