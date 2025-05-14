import "dart:async";
import "dart:collection";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:scale_up/utils/extensions/num_duration_extension.dart";

/// A wrapper class that is the only one that has access to the
///   [FirebaseFirestore] instance. All interactions with cloud
///   Firestore should go through this class.
class FirestoreHelper {
  static FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> get _userCollection =>
      _firestore.collection("users");

  const FirestoreHelper();

  Future<(DocumentReference<Map<String, Object?>>, T)> getUserObject<T>({
    required User user,
    required String key,
  }) async {
    var userDoc = await _createUserDocumentIfNotExists(user);
    var data = await userDoc.get().then((d) => d.data()![key]) as T;

    return (userDoc, data);
  }

  Future<
    ({
      Map<String, DateTime> finishedChapters, //
      Duration totalTimeInLessons,
      int correctAnswers,
      int totalAnswers,
    })
  >
  getUserData({required User user}) async {
    var (_, rawChapters) = await getUserObject<Map<String, Object?>>(
      user: user,
      key: "finished_chapters",
    );
    var (_, totalTimeInLessonMs) = await getUserObject<int>(
      user: user,
      key: "total_time_in_lesson_ms",
    );
    var (_, correctAnswers) = await getUserObject<int>(user: user, key: "correct_answers");
    var (_, totalAnswers) = await getUserObject<int>(user: user, key: "total_answers");

    var entries = rawChapters.pairs
        .where((p) => p.$2 is int)
        .cast<(String, int)>()
        .map((p) => (p.$1, DateTime.fromMillisecondsSinceEpoch(p.$2)))
        .map((p) => MapEntry(p.$1, p.$2));

    var finishedChapters = Map<String, DateTime>.fromEntries(entries);
    var totalTimeInLessons = Duration(milliseconds: totalTimeInLessonMs);

    return (
      finishedChapters: finishedChapters,
      totalTimeInLessons: totalTimeInLessons,
      correctAnswers: correctAnswers,
      totalAnswers: totalAnswers,
    );
  }

  static Timer? _registerDebounce;
  static final _registerQueue = Queue<(String, int, DateTime, Duration, int, int)>();
  Future<void> registerChapterAsCompleted({
    required User user,
    required String lessonId,
    required int chapterIndex,
    required ChapterType chapterType,
    required DateTime finishedDate,
    required Duration lessonDuration,
    required int correctAnswers,
    required int totalAnswers,
  }) async {
    _registerQueue.add((
      lessonId,
      chapterIndex,
      finishedDate,
      lessonDuration,
      correctAnswers,
      totalAnswers,
    ));

    if (_registerDebounce?.isActive ?? false) {
      _registerDebounce?.cancel();
    }

    _registerDebounce = Timer(1.seconds, () async {
      var doc = await _createUserDocumentIfNotExists(user);
      var changes = <String, Object>{};

      /// Update the time stamps.
      for (var (lessonId, chapterIndex, dateTime, _, _, _) in _registerQueue) {
        var key = chapterType.stringify(lessonId, chapterIndex);
        var stringKey = "finished_chapters.$key";

        changes[stringKey] = dateTime.millisecondsSinceEpoch;
      }

      /// Update the total time in lesson (ms).
      int totalTimeAdded = 0;
      for (var (_, _, _, duration, _, _) in _registerQueue) {
        totalTimeAdded += duration.inMilliseconds;
      }
      changes["total_time_in_lesson_ms"] = FieldValue.increment(totalTimeAdded);

      /// Update the correct answers.
      int totalCorrectAdded = 0;
      int totalAnswersAdded = 0;
      for (var (_, _, _, _, correct, total) in _registerQueue) {
        totalCorrectAdded += correct;
        totalAnswersAdded += total;
      }
      changes["correct_answers"] = FieldValue.increment(totalCorrectAdded);
      changes["total_answers"] = FieldValue.increment(totalAnswersAdded);

      await doc.update(changes);

      _registerQueue.clear();
    });
  }

  static Future<DocumentReference<Map<String, Object?>>> _createUserDocumentIfNotExists(
    User user,
  ) async {
    var userDoc = _userCollection.doc(user.uid);
    if (await userDoc.get().then((d) => !d.exists)) {
      await userDoc.set({
        "uid": user.uid,
        "finished_chapters": <String, int>{},
        "total_time_in_lesson_ms": 0,
        "correct_answers": 0,
        "total_answers": 0,
        "createdAt": FieldValue.serverTimestamp(),
      });
    }

    return _userCollection.doc(user.uid);
  }
}

enum ChapterType {
  practice(_practiceStringify),
  learn(_learnStringify);

  static (String, ChapterType, int)? tryParse(String input) {
    var split = input.split(":");
    if (split.length != 3) return null;
    if (split case [var id, ("p" || "l") && var middle, var rawIndex]) {
      if (int.tryParse(rawIndex) case var index?) {
        var type =
            switch (middle) {
              "p" => ChapterType.practice,
              "l" => ChapterType.learn,
              _ => null,
            }!;
        return (id, type, index);
      }
    }

    return null;
  }

  static String _practiceStringify(String id, int idx) => "$id:p:$idx";
  static String _learnStringify(String id, int idx) => "$id:l:$idx";

  final String Function(String lessonId, int chapterIndex) stringify;

  const ChapterType(this.stringify);
}

extension<K, V> on Map<K, V> {
  Iterable<(K, V)> get pairs => entries.map((e) => (e.key, e.value));
}
