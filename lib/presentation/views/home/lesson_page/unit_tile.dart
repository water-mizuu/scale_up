import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
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
  late final Future<Unit?> unitFuture = context.read<LessonsHelper>().getUnit(widget.unit);
  late final SuperTooltipController tooltipController = SuperTooltipController();
  bool isShown = false;

  @override
  void dispose() {
    tooltipController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lesson = context.read<LessonPageCubit>().state.lesson;
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return FutureBuilder(
      future: unitFuture,
      builder: (context, snapshot) {
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
              unitFuture: unitFuture,
              lesson: lesson,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),

              /// This material widget makes sure that the ink doesn't overflow
              ///   through clipping like in scroll views.
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (snapshot.data case Unit(:var shortcut))
                      FittedBox(fit: BoxFit.scaleDown, child: Styles.title(shortcut))
                    else
                      SizedBox(),
                    //
                    FittedBox(fit: BoxFit.scaleDown, child: Text(widget.unit)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class UnitToolTip extends StatelessWidget {
  const UnitToolTip({
    super.key,
    required this.lessonPageCubit,
    required this.unitFuture,
    required this.lesson,
  });

  final LessonPageCubit lessonPageCubit;
  final Future<Unit?> unitFuture;
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: unitFuture,
      builder: (context, snapshot) {
        return IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Styles.subtitle("Direct Conversions"),
              if (snapshot.data case var unit?)
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
                                  InheritedProvider<Future<Unit?>>(
                                    create:
                                        (_) => context.read<LessonsHelper>().getUnit(
                                          conversion.to,
                                        ),
                                    builder: (context, _) {
                                      return FutureBuilder(
                                        future: context.read<Future<Unit?>>(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data case Unit(:var shortcut)) {
                                            return Text(shortcut);
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        },
                                      );
                                    },
                                  ),
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
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
