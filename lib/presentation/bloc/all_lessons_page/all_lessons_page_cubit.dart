import "dart:collection";
import "dart:math";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/all_lessons_page/all_lessons_page_state.dart";

export "all_lessons_page_state.dart";

int _editDistance(String a, String b) {
  return _leveshtein(a.toLowerCase(), b.toLowerCase());
}

int _leveshtein(String s, String t) {
  List<int> v0 = List<int>.generate(t.length + 1, (i) => i);
  List<int> v1 = List<int>.generate(t.length + 1, (i) => 0);

  for (int i = 0; i < s.length; i++) {
    v1[0] = i + 1;

    for (int j = 0; j < t.length; j++) {
      int deletionCost = v0[j + 1] + 1;
      int insertionCost = v1[j] + 1;
      int substitutionCost = s[i] == t[j] ? v0[j] : v0[j] + 1;

      int chosen = [deletionCost, insertionCost, substitutionCost].reduce(min);
      v1[j + 1] = chosen;
    }

    v0 = [...v1];
  }

  return v0[t.length];
}

class AllLessonsPageCubit extends Cubit<AllLessonsPageState> {
  AllLessonsPageCubit(this._lessonsHelper, List<Lesson> lessons)
    : super(AllLessonsPageState(lessons: lessons, categoriesByTitle: [], keywords: {})) {
    _updateAllPartitions();
  }

  final LessonsHelper _lessonsHelper;

  /// This function is used to populate the categoriesByTitle list.
  void _updateAllPartitions() {
    var allLessons = {...state.lessons};

    /// We basically remove all the lessons which:
    ///   - Do not match any keyword:
    ///     - In the category.
    ///     - In the name
    ///     - In the units involved

    var unitMap = <(String, String), Unit?>{};
    Unit? unitOf(String lesson, String unitId) {
      var lessonObject = allLessons.cast<Lesson?>().firstWhere(
        (l) => l?.id == lesson,
        orElse: () => null,
      );
      if (lessonObject == null) return null;

      return unitMap.putIfAbsent((
        lesson,
        unitId,
      ), () => _lessonsHelper.getUnit(lessonObject.unitsType, unitId));
    }

    var scores = <Lesson, int>{};
    for (var lesson in state.lessons) {
      var score = 1_000_000;
      for (var keyword in state.keywords) {
        score = min(score, _editDistance(lesson.category, keyword));
        score = min(score, _editDistance(lesson.name, keyword));
        score = min(
          score,
          lesson.units
              .expand(
                (unit) => [
                  _editDistance(unit, keyword),
                  if (unitOf(lesson.id, keyword)?.display case var display?)
                    _editDistance(display.toLowerCase(), keyword),
                ],
              )
              .reduce(min),
        );
      }
      scores[lesson] = score;
    }

    var minimumScore = scores.values.reduce(min);
    var sorted =
        allLessons //
            .where((l) => scores.containsKey(l))
            .where((l) => scores[l]! <= 1.5 * minimumScore)
            .toList() //
          ..sort((a, b) => scores[a]!.compareTo(scores[b]!));

    /// We now have all the lessons which match the keywords.
    /// We now need to group them by category.
    // ignore: prefer_collection_literals
    var categoriesByTitle = LinkedHashMap<String, List<Lesson>>();
    for (var lesson in sorted) {
      categoriesByTitle.putIfAbsent(lesson.category, () => []).add(lesson);
    }

    state.categoriesByTitle
      ..clear()
      ..addAll(categoriesByTitle.entries.map((e) => (e.key, e.value)));
  }

  void updateType(String rawInput) {
    state.keywords.clear();
    if (rawInput.trim().isNotEmpty) {
      state.keywords.addAll(rawInput.toLowerCase().split(" ").toSet());
    }

    _updateAllPartitions();
    emit(state.update());
  }
}
