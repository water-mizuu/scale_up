import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_state.dart";

class LessonPageCubit extends Cubit<LessonPageState> {
  LessonPageCubit(LessonsHelper lessonsHelper, Lesson lesson)
    : super(LessonPageState(lesson: lesson)) {
    var unitGroup = lesson.unitsType;

    lessonsHelper.getExtendedUnitGroup(unitGroup).then((unitGroup) {
      if (unitGroup != null) {
        /// The localized unit group is the unit group without the non-included units.

        var unitGroupCopy = unitGroup.copyWith(
          units: [
            for (var unit in lesson.units)
              unitGroup.units.firstWhere((unitGroupUnit) => unitGroupUnit.id == unit),
          ],
          conversions: [
            for (var conversion in unitGroup.conversions)
              if (lesson.units.contains(conversion.from) &&
                  lesson.units.contains(conversion.to))
                conversion,
          ],
        );

        emit(state.copyWith(localUnitGroup: unitGroupCopy));
      }
    });
  }
}
