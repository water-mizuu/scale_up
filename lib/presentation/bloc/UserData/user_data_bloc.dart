import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_event.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_state.dart";

export "user_data_event.dart";
export "user_data_state.dart";

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc({required FirestoreHelper firestoreHelper})
    : _firestoreHelper = firestoreHelper,
      super(
        UserDataState(
          user: null,
          status: UserDataStatus.none,
          finishedChapters: {},
          totalTimeInLessons: Duration.zero,
          correctAnswers: 0,
          totalAnswers: 0,
        ),
      ) {
    on<SignedInUserDataEvent>(_onSignedIn);
    on<SignedOutUserDataEvent>(_onSignedOut);
    on<ChapterCompletedUserDataEvent>(_onChapterCompleted);
  }

  final FirestoreHelper _firestoreHelper;

  Future<void> _onSignedIn(SignedInUserDataEvent event, Emitter<UserDataState> emit) async {
    try {
      emit(state.copyWith(status: UserDataStatus.loading));

      var (:finishedChapters, :correctAnswers, :totalAnswers, :totalTimeInLessons) = //
          await _firestoreHelper.getUserData(user: event.user);

      emit(
        state.copyWith(
          status: UserDataStatus.loaded,
          user: event.user,
          finishedChapters: finishedChapters,
          totalTimeInLessons: totalTimeInLessons,
          correctAnswers: correctAnswers,
          totalAnswers: totalAnswers,
        ),
      );
    } on Object {
      emit(state.copyWith(status: UserDataStatus.loaded, user: null));
    }
  }

  Future<void> _onSignedOut(SignedOutUserDataEvent event, Emitter<UserDataState> emit) async {
    emit(state.copyWith(status: UserDataStatus.loading));
    await Future.delayed(Duration.zero);
    emit(state.copyWith(status: UserDataStatus.loaded, user: null, finishedChapters: {}));
  }

  Future<void> _onChapterCompleted(
    ChapterCompletedUserDataEvent event,
    Emitter<UserDataState> emit,
  ) async {
    var ChapterCompletedUserDataEvent(
      :chapterIndex,
      :chapterType,
      :lessonId,
      :duration,
      :totalAnswers,
      :correctAnswers,
    ) = event;

    print(state.user);
    if (state case UserDataState(:var user?)) {
      var key = chapterType.stringify(lessonId, chapterIndex);

      var finishedDate = DateTime.now();
      var finishedChapters = {...state.finishedChapters, key: finishedDate};
      emit(state.copyWith(finishedChapters: finishedChapters));

      unawaited(
        _firestoreHelper.registerChapterAsCompleted(
          user: user,
          lessonId: lessonId,
          chapterIndex: chapterIndex,
          chapterType: chapterType,
          finishedDate: finishedDate,
          lessonDuration: duration,
          totalAnswers: totalAnswers,
          correctAnswers: correctAnswers,
        ),
      );
    }
  }
}
