import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/presentation/views/home/lesson_page/unit_tile.dart";

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
            children: [for (var unit in context.read<Lesson>().units) UnitTile(unit: unit)],
          ),
        ),
      ],
    );
  }
}
