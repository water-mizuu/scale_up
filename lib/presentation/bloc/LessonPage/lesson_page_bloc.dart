import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/lesson.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_event.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_state.dart";

class LessonPageBloc extends Bloc<LessonPageEvent, LessonPageState> {
  LessonPageBloc(Lesson lesson) : super(LessonPageState(lesson: lesson, chapterIndex: null)) {
    on<ChapterSelectedEvent>(_onChapterSelected);
  }

  Future<void> _onChapterSelected(
    ChapterSelectedEvent event,
    Emitter<LessonPageState> emit,
  ) async {
    if (kDebugMode) {
      print("Chapter selected: ${event.chapterIndex}");
    }

    emit(state.copyWith(chapterIndex: event.chapterIndex));
  }
}
