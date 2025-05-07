import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_state.dart";

class PracticeCongratulatoryBarrier extends StatelessWidget {
  const PracticeCongratulatoryBarrier({super.key});

  @override
  Widget build(BuildContext context) {
    var status = context.select((PracticePageBloc b) => b.loadedState.status);
    if (status != PracticePageStatus.correct && status != PracticePageStatus.incorrect) {
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
