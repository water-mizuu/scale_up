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
      super(UserDataState(user: null, status: UserDataStatus.none, finishedChapters: {})) {
    on<SignedInUserDataEvent>(_onSignedIn);
    on<SignedOutUserDataEvent>(_onSignedOut);
    on<ChapterCompletedUserDataEvent>(_onChapterCompleted);
  }

  final FirestoreHelper _firestoreHelper;

  Future<void> _onSignedIn(SignedInUserDataEvent event, Emitter<UserDataState> emit) async {
    emit(state.copyWith(status: UserDataStatus.loading));

    var finishedChapters = await _firestoreHelper.getCompletedChapters(user: event.user);

    emit(
      state.copyWith(
        status: UserDataStatus.loaded,
        user: event.user,
        finishedChapters: finishedChapters,
      ),
    );
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
    if (state case UserDataState(:var user?)) {
      var ChapterCompletedUserDataEvent(:lessonId, :chapterIndex) = event;
      var key = "$lessonId:$chapterIndex";

      var finishedChapters = state.finishedChapters..add(key);
      emit(state.copyWith(finishedChapters: finishedChapters));

      unawaited(_firestoreHelper.registerChapterAsCompletedAsync(user, lessonId, chapterIndex));
    }
  }
}
