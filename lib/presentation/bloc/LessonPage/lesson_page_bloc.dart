import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_event.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_state.dart";

class LessonPageBloc extends Bloc<LessonPageEvent, LessonPageState> {
  LessonPageBloc(Lesson lesson) : super(LessonPageState(lesson: lesson));
}
