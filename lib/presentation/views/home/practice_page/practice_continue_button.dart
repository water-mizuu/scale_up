import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_state.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_check_button.dart";

/// This widget is used to show the continue button.
class PracticeContinueButton extends StatelessWidget {
  const PracticeContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.select((PracticePageBloc b) => b.loadedState);

    if (state.status case PracticePageStatus.correct || PracticePageStatus.incorrect) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0) - const EdgeInsets.only(top: 16.0),
          child: const PracticeCheckButton(),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
