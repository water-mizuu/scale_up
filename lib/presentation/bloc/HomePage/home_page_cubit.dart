import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
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
    var allLessons = await _lessonsHelper.lessons;
    var finishedChaptersLessonIds =
        finishedChaptersString
            // The format is "$lessonId:$index"
            .map((s) => s.split(":"))
            // We take only the lesson id.
            .map((s) => s[0]) //
            .toList();

    var count = {for (var lessonId in finishedChaptersLessonIds) lessonId: 0};
    for (var key in finishedChaptersLessonIds) {
      count[key] = count[key]! + 1;
    }

    var ongoingLessons = [
      for (var lesson in allLessons)
        if (count[lesson.id] case var chapterCount?
            when 0 < chapterCount && chapterCount < lesson.practiceChapters.length)
          lesson,
    ]..sort(
      (a, b) => (count[b.id]! / b.practiceChapters.length).compareTo(
        (count[a.id]! / a.practiceChapters.length),
      ),
    );

    var newLessons = [
      for (var lesson in allLessons)
        if (count[lesson.id] case null || 0) lesson,
    ];

    var finishedLessons = [
      for (var lesson in allLessons)
        if (count[lesson.id] case var chapterCount?
            when chapterCount >= lesson.practiceChapters.length)
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

  // Future<List<Lesson>> get ongoingLessons async {
  //   var allLessons = await _lessonsHelper.lessons;
  //   var finishedChapters = await Future.wait([]);

  //   return [];

  //   // var questionsDone = context.select<UserDataBloc, int>(
  //   //   (bloc) => bloc.state.finishedChapters
  //   //       /// We only take the tags that start with this lesson
  //   //       .where((n) => n.startsWith(id))
  //   //       /// We take the string indices
  //   //       .map((v) => v.substring(id.length + 1))
  //   //       /// We parse the indices to integers
  //   //       .map((s) => int.parse(s))
  //   //       /// We get the chapter object from the lesson object, reading the questionCount.
  //   //       .map((s) => chapters[s].questionCount)
  //   //       /// And we sum them all up.
  //   //       .fold(0, (a, b) => a + b),
  //   // );
  // }
}
