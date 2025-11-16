import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_check_button.dart";

class LearnContinueButton extends StatelessWidget {
  const LearnContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.select((LearnPageBloc b) => b.loadedState);

    if (state.status case LearnPageStatus.correct || LearnPageStatus.incorrect) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0) - const EdgeInsets.only(top: 16.0),
          child: const LearnCheckButton(),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
