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
        Styles.subtitle("Units Involved"),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            children: [
              for (var (index, unit)
                  in context.read<LessonPageCubit>().state.lesson.units.indexed)
                UnitTile(unit: unit)
                    .animate()
                    .then(delay: (index * 100).milliseconds)
                    .slideY(duration: 250.ms, begin: 0.1, end: 0.0)
                    .fadeIn(duration: 250.ms),
            ],
          ),
        ),
      ],
    );
  }
}
