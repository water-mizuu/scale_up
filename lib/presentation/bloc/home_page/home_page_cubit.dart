import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/home_page/home_page_state.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required UserDataState state, required LessonsHelper lessonsHelper})
    : _lessonsHelper = lessonsHelper,
      super(
        HomePageState(
          lastLessonReviewed: null,
          ongoingLessons: [],
          newLessons: [],
          finishedLessons: [],
          chaptersFinished: 0,
          averageTimePerChapter: Duration.zero,
          correctRate: 0,
        ),
      ) {
    Future.delayed(Duration.zero, () {
      updateFinishedChaptersString(state.finishedChapters);
      updateStatistics(
        totalTimeInLessons: state.totalTimeInLessons,
        chaptersFinished: state.finishedChapters.length,
        correctAnswers: state.correctAnswers,
        totalAnswers: state.totalAnswers,
      );
    });
  }

  final LessonsHelper _lessonsHelper;

  void updateFinishedChaptersString(Map<String, DateTime> finishedChaptersString) async {
    var allLessons = _lessonsHelper.lessons;
    var finishedChaptersLessonIds =
        finishedChaptersString.keys
            // The format is "$lessonId:$index"
            .map((s) => ChapterType.tryParse(s)!)
            // We take only the lesson id.
            .map((s) => s.$1) //
            .toList();

    /// Count the amount each chapter has been reviewed.
    var reviewCount = {for (var lessonId in finishedChaptersLessonIds) lessonId: 0};
    for (var key in finishedChaptersLessonIds) {
      reviewCount[key] = reviewCount[key]! + 1;
    }

    /// Get the last lesson reviewed.
    Lesson? lastLessonReviewed;
    var listOfChapters =
        finishedChaptersString.entries.map((e) => (e.key, e.value)).toList()
          ..sort((a, b) => -a.$2.difference(b.$2).inMilliseconds);
    if (listOfChapters.firstOrNull case (var chapterId, _)) {
      if (ChapterType.tryParse(chapterId) case (var lessonId, _, _)) {
        lastLessonReviewed = _lessonsHelper.getLesson(lessonId);
      }
    }

    /// A helper function to get the fractional progression
    ///   of a specific lesson.
    double progression(Lesson lesson) =>
        reviewCount[lesson.id] != null
            ? (reviewCount[lesson.id]! / lesson.chapterCount) //
            : 0;

    var ongoingLessons = [
      for (var lesson in allLessons)
        if (reviewCount[lesson.id] case var chapterCount?
            when 0 < chapterCount && chapterCount < lesson.chapterCount)
          if (lesson != lastLessonReviewed) lesson,
    ]..sort((a, b) => progression(b).compareTo(progression(a)));

    var newLessons = [
      for (var lesson in allLessons)
        if (reviewCount[lesson.id] case null || 0) lesson,
    ];

    var finishedLessons = [
      for (var lesson in allLessons)
        if (reviewCount[lesson.id] case var chapterCount?
            when chapterCount >= lesson.chapterCount)
          lesson,
    ];

    emit(
      state.copyWith(
        lastLessonReviewed: lastLessonReviewed,
        ongoingLessons: ongoingLessons,
        newLessons: newLessons,
        finishedLessons: finishedLessons,
      ),
    );
  }

  void updateStatistics({
    required Duration totalTimeInLessons,
    required int chaptersFinished,
    required int correctAnswers,
    required int totalAnswers,
  }) {
    var averageTimePerChapter =
        chaptersFinished == 0
            ? (Duration.zero) //
            : totalTimeInLessons * (1 / chaptersFinished);

    var correctRate =
        totalAnswers == 0
            ? 0 //
            : ((correctAnswers / totalAnswers) * 100).round();

    emit(
      state.copyWith(
        chaptersFinished: chaptersFinished,
        averageTimePerChapter: averageTimePerChapter,
        correctRate: correctRate,
      ),
    );
  }
}
