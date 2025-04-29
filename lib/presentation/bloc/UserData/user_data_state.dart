import "package:firebase_auth/firebase_auth.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "user_data_state.freezed.dart";

enum UserDataStatus { none, loading, loaded, updatingCompletedChapters }

@freezed
abstract class UserDataState with _$UserDataState {
  const UserDataState._();

  const factory UserDataState({
    required User? user,
    required UserDataStatus status,
    required Map<String, DateTime> finishedChapters,
  }) = _UserDataState;
}
