import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";

class CompletedCalculatePracticeBody extends StatelessWidget {
  const CompletedCalculatePracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.read<PracticePageBloc>() case var chapterPageBloc)
            if (chapterPageBloc.state.progress case var progress?)
              Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: FAProgressBar(
                  key: progressBarKey,
                  backgroundColor: Colors.white,
                  currentValue: progress * 100,
                  animatedDuration: const Duration(milliseconds: 150),
                ),
              ),
          Expanded(child: Center(child: Text("Congrats! You done bro"))),
        ],
      ),
    );
  }
}
