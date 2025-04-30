import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/views/home/lesson_page/unit_tile.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonUnits extends StatelessWidget {
  const LessonUnits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Units To Learn", fontWeight: FontWeight.w600),
        for (var group in context.read<LessonPageCubit>().state.lesson.units.indexed.batch(2))
          Row(
            spacing: 8.0,
            children: [
              for (var (index, element) in group)
                Expanded(
                  child: UnitTile(unitString: element)
                      .animate()
                      .then(delay: (index * 100).milliseconds)
                      .slideY(duration: 250.ms, begin: 0.1, end: 0.0)
                      .fadeIn(duration: 250.ms),
                ),
            ],
          ),
      ],
    );
  }
}

extension BatchExtension<T> on Iterable<T> {
  Iterable<List<T>> batch(int numberOfElementPerBatch) sync* {
    Iterator<T> iter = iterator;
    List<T> values = [];
    while (iter.moveNext()) {
      values.add(iter.current);

      if (values.length == numberOfElementPerBatch) {
        yield values;
        values = [];
      }
    }

    if (values.length <= numberOfElementPerBatch) {
      yield values;
      values = [];
    }
  }
}
