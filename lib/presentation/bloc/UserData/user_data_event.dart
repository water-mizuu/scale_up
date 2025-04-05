import "package:firebase_auth/firebase_auth.dart";

sealed class UserDataEvent {
  const UserDataEvent();
}

final class LoggedInUserDataEvent extends UserDataEvent {
  final User user;

  const LoggedInUserDataEvent({required this.user});
}

final class LoggedOutUserDataEvent extends UserDataEvent {
  const LoggedOutUserDataEvent();
}

final class ChapterCompletedUserDataEvent extends UserDataEvent {
  final String lessonId;
  final int chapterIndex;

  const ChapterCompletedUserDataEvent({required this.lessonId, required this.chapterIndex});
}
