import "package:firebase_auth/firebase_auth.dart";

sealed class UserDataEvent {
  const UserDataEvent();
}

final class SignedInUserDataEvent extends UserDataEvent {
  final User user;

  const SignedInUserDataEvent({required this.user});
}

final class SignedOutUserDataEvent extends UserDataEvent {
  const SignedOutUserDataEvent();
}

final class ChapterCompletedUserDataEvent extends UserDataEvent {
  final String lessonId;
  final int chapterIndex;

  const ChapterCompletedUserDataEvent({required this.lessonId, required this.chapterIndex});
}
