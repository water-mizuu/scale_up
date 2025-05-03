import "package:firebase_auth/firebase_auth.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";

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
  final ChapterType chapterType;
  final int correctAnswers;
  final int totalAnswers;
  final Duration duration;

  const ChapterCompletedUserDataEvent({
    required this.lessonId,
    required this.chapterIndex,
    required this.chapterType,
    required this.correctAnswers,
    required this.totalAnswers,
    required this.duration,
  });
}
