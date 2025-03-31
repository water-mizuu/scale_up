import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LessonsPage/lessons_page_state.dart";

export "lessons_page_state.dart";

class LessonsPageCubit extends Cubit<LessonsPageState> {
  LessonsPageCubit() : super(const LessonsPageState(keywords: {}));

  void updateType(String rawInput) {
    if (rawInput.trim().isEmpty) {
      emit(state.copyWith(keywords: const {}));
    } else {
      emit(state.copyWith(keywords: rawInput.toLowerCase().split(" ").toSet()));
    }
  }
}
