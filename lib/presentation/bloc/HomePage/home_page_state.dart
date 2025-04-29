import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/models/lesson.dart";

part "home_page_state.freezed.dart";

@freezed
sealed class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({
    required List<Lesson> ongoingLessons,
    required List<Lesson> newLessons,
    required List<Lesson> finishedLessons,
    required Duration averageTimePerLesson,
    required Duration averageTimePerQuestion,
    required int lessonsCompleted,
  }) = _HomePageState;
}
