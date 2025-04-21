import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:super_tooltip/super_tooltip.dart";

const TextStyle mini = TextStyle(fontSize: 12);

class UnitTile extends StatefulWidget {
  const UnitTile({required this.unit, super.key});

  final String unit;

  @override
  State<UnitTile> createState() => _UnitTileState();
}

class _UnitTileState extends State<UnitTile> {
  late final SuperTooltipController tooltipController = SuperTooltipController();
  bool isShown = false;

  @override
  void dispose() {
    tooltipController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var unit = context.read<LessonsHelper>().getUnit(widget.unit);
    var lesson = context.read<LessonPageCubit>().state.lesson;
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return GestureDetector(
      onTap: () {
        if (isShown) {
          tooltipController.hideTooltip();
        } else {
          tooltipController.showTooltip();
        }
        isShown = !isShown;
      },
      child: SuperTooltip(
        controller: tooltipController,
        content: UnitToolTip(
          lessonPageCubit: context.read<LessonPageCubit>(),
          unit: unit,
          lesson: lesson,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
            boxShadow: defaultBoxShadow,
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

                FittedBox(fit: BoxFit.scaleDown, child: Text(widget.unit)),
              ],
            ),
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
