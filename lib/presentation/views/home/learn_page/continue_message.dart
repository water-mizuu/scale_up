import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_page_check_button.dart";

class ContinueMessage extends StatelessWidget {
  const ContinueMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnPageBloc, LearnPageState>(
      buildWhen: (p, c) => (p as LoadedLearnPageState).status == LearnPageStatus.evaluating,
      builder: (context, state) {
        if (state.status case LearnPageStatus.correct || LearnPageStatus.incorrect) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0) - EdgeInsets.only(top: 16.0),
                child: LearnPageCheckButton(),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
