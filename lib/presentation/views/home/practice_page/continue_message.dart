import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_state.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_check_button.dart";

/// This widget is used to show the continue button.
class ContinueMessage extends StatelessWidget {
  const ContinueMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticePageBloc, PracticePageState>(
      buildWhen: (p, c) => (p as LoadedPracticePageState).status == PracticePageStatus.evaluating,
      builder: (context, state) {
        if (state.status case PracticePageStatus.correct || PracticePageStatus.incorrect) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0) - const EdgeInsets.only(top: 16.0),
                child: const PracticeCheckButton(),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
