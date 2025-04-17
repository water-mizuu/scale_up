import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";

part "home_page_state.freezed.dart";

@freezed
sealed class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({
    @Default([]) List<Lesson> ongoingLessons,
    @Default([]) List<Lesson> newLessons,
    @Default([]) List<Lesson> finishedLessons,
  }) = _HomePageState;
}
