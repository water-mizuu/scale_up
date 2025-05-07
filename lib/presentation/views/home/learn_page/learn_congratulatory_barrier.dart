import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";

class LearnCongratulatoryBarrier extends StatelessWidget {
  const LearnCongratulatoryBarrier({super.key});

  @override
  Widget build(BuildContext context) {
    var status = context.select((LearnPageBloc b) => b.loadedState.status);
    if (status != LearnPageStatus.correct && status != LearnPageStatus.incorrect) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (kDebugMode) {
          print("Tap input denied");
        }
      },
    );
  }
}
