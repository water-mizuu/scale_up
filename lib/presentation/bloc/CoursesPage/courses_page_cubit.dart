import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/CoursesPage/courses_page_state.dart';

export 'courses_page_state.dart';

class CoursesPageCubit extends Cubit<CoursesPageState> {
  CoursesPageCubit() : super(const CoursesPageState(keywords: {}));

  void updateType(String rawInput) {
    if (rawInput.trim().isEmpty) {
      emit(state.copyWith(keywords: const {}));
    } else {
      emit(state.copyWith(keywords: rawInput.toLowerCase().split(" ").toSet()));
    }
  }
}
