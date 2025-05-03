import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/presentation/bloc/indirect_steps/indirect_steps_cubit.dart";
import "package:scale_up/presentation/bloc/indirect_steps/indirect_steps_state.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices/blank_choice_unit_tile.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices/choice_unit_tile.dart";

class IndirectStepsChoice extends StatelessWidget {
  const IndirectStepsChoice({super.key, required this.index, required this.unit});

  final int index;
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    var (key, stateUnit, isAnimating) = context.select((IndirectStepsCubit c) {
      var state = c.state as ActiveIndirectStepsState;

      return (
        state.choiceKeys[index],
        state.choices[index],
        state.status == IndirectStepsStatus.animating,
      );
    });

    /// If the stateUnit is null, it means that the user has selected this unit.
    if (stateUnit == null) {
      return BlankChoiceUnitTile(key: key, unit: unit);
    }

    return ChoiceUnitTile(
      key: key,
      unit: unit,
      onTap: () {
        if (isAnimating) {
          return null;
        }

        return () {
          HapticFeedback.selectionClick();

          context.read<IndirectStepsCubit>().answer(index);
        };
      }(),
    );
  }
}
