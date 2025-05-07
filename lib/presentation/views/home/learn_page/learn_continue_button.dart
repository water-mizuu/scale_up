import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:scale_up/hooks/use_bloc_builder.dart";
import "package:scale_up/hooks/use_provider_hooks.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_check_button.dart";

class LearnContinueButton extends HookWidget {
  const LearnContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    var learnPageBloc = useRead<LearnPageBloc>();
    var state = useBlocBuilder(
      learnPageBloc,
      buildWhen: (p, c) => (p as LoadedLearnPageState).status == LearnPageStatus.evaluating,
    );

    if (state is! LoadedLearnPageState) {
      return const SizedBox.shrink();
    }

    if (state.status case LearnPageStatus.correct || LearnPageStatus.incorrect) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0) - const EdgeInsets.only(top: 16.0),
            child: const LearnCheckButton(),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
