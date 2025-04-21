import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_state.dart";

class LessonPageCubit extends Cubit<LessonPageState> {
  LessonPageCubit(this._lessonsHelper, Lesson lesson) : super(LessonPageState(lesson: lesson)) {
    _loadLocalUnitGroup();
  }

  final LessonsHelper _lessonsHelper;

  void _loadLocalUnitGroup() {
    var localUnitGroup = _lessonsHelper.getLocalExtendedUnitGroup(
      state.lesson.unitsType,
      state.lesson.units,
    );

    if (localUnitGroup != null) {
      emit(state.copyWith(localUnitGroup: localUnitGroup));
    }
  }
}
