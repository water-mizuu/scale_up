import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/border_color.dart";
import "package:scale_up/utils/title_case.dart";
import "package:scale_up/utils/tool_tip.dart";

const TextStyle mini = TextStyle(fontSize: 12);

class UnitTile extends StatelessWidget {
  const UnitTile({required this.unitString, super.key});

  final String unitString;

  @override
  Widget build(BuildContext context) {
    var unit = context.read<LessonsHelper>().getUnit(unitString);
    var lesson = context.read<LessonPageCubit>().state.lesson;
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return ToolTip(
      content: UnitToolTip(
        lessonPageCubit: context.read<LessonPageCubit>(),
        unit: unit,
        lesson: lesson,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
          border: Border.all(color: Colors.white.borderColor),
        ),

        /// This material widget makes sure that the ink doesn't overflow
        ///   through clipping like in scroll views.
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (unit case Unit(:var shortcut))
                FittedBox(fit: BoxFit.scaleDown, child: Styles.title(shortcut)),

              if (unit case Unit(:var display?))
                FittedBox(fit: BoxFit.scaleDown, child: Text(display))
              else
                FittedBox(fit: BoxFit.scaleDown, child: Text(unitString.toTitleCase())),
            ],
          ),
        ),
      ),
    );
  }
}

class UnitToolTip extends StatelessWidget {
  const UnitToolTip({
    super.key,
    required this.lessonPageCubit,
    required this.unit,
    required this.lesson,
  });

  final LessonPageCubit lessonPageCubit;
  final Unit? unit;
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Styles.subtitle("Direct Conversions", fontWeight: FontWeight.w600),
          if (unit case var unit?)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lessonPageCubit.state.localUnitGroup case var unitGroup?)
                  Row(
                    spacing: 8.0,
                    children: [
                      Column(
                        children: [
                          for (var conversion in unitGroup.conversions)
                            if (conversion.from == unit.id)
                              if (context.read<LessonsHelper>().getUnit(conversion.to)
                                  case var unit?)
                                Text(unit.shortcut),
                        ],
                      ),
                      Column(
                        children: [
                          for (var conversion in unitGroup.conversions)
                            if (conversion.from == unit.id) Text("="),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var conversion in unitGroup.conversions)
                            if (conversion.from == unit.id)
                              Text(
                                conversion.formula
                                    .substitute("from", VariableExpression(unit.shortcut))
                                    .toString(),
                              ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
