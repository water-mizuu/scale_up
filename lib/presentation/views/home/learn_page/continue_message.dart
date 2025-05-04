import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_check_button.dart";

class ContinueMessage extends StatelessWidget {
  const ContinueMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnPageBloc, LearnPageState>(
      buildWhen: (p, c) => (p as LoadedLearnPageState).status == LearnPageStatus.evaluating,
      builder: (context, state) {
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
      },
    );
  }
}
