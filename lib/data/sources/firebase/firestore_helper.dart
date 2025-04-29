import "dart:async";
import "dart:collection";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

/// A wrapper class that is the only one that has access to the
///   [FirebaseFirestore] instance. All interactions with cloud
///   Firestore should go through this class.
class FirestoreHelper {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get _userCollection => _firestore.collection("users");

  const FirestoreHelper();

  Future<Map<String, DateTime>> getFinishedChapters({required User user}) async {
    var userDoc = await _createUserDocumentIfNotExists(user);
    var finishedChapters = await userDoc //
        .get()
        .then((d) => d.data()!["finished_chapters"]! as Map<String, Object?>)
        .then((l) => l.pairs.where((p) => p.$2 is int).map((p) => (p.$1, p.$2 as int)))
        .then((l) => l.map((p) => (p.$1, DateTime.fromMillisecondsSinceEpoch(p.$2))))
        .then((l) => l.map((p) => MapEntry(p.$1, p.$2)))
        .then((p) => Map.fromEntries(p));

    return finishedChapters;
  }

  static Timer? _registerDebounce;
  static final _registerQueue = Queue<(String, int, DateTime)>();
  Future<void> registerChapterAsCompleted({
    required User user,
    required String lessonId,
    required int chapterIndex,
    required ChapterType chapterType,

    required DateTime finishedDate,
  }) async {
    _registerQueue.add((lessonId, chapterIndex, finishedDate));

    if (_registerDebounce?.isActive ?? false) {
      _registerDebounce?.cancel();
    }

    _registerDebounce = Timer(Duration(seconds: 1), () async {
      var userDoc = await _createUserDocumentIfNotExists(user);
      var finishedChapters = await userDoc.get().then((d) => d.data()!["finished_chapters"]!);
      if (finishedChapters case Map<String, Object?> finishedChapters) {
        for (var (lessonId, chapterIndex, dateTime) in _registerQueue) {
          var key = chapterType.stringify(lessonId, chapterIndex);

          finishedChapters[key] = dateTime.millisecondsSinceEpoch;
        }

        await userDoc.update({"finished_chapters": finishedChapters});
        _registerQueue.clear();
      } else {
        throw Exception(finishedChapters);
      }
    });
  }

  Future<DocumentReference<Map<String, Object?>>> _createUserDocumentIfNotExists(
    User user,
  ) async {
    var userDoc = _userCollection.doc(user.uid);
    if (await userDoc.get().then((d) => !d.exists)) {
      await userDoc.set({
        "uid": user.uid,
        "finished_chapters": <String, int>{},
        "total_answer_duration_in_ms": 0,
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

  static String _practiceStringify(String lessonId, int chapterIndex) =>
      "$lessonId:p:$chapterIndex";
  static String _learnStringify(String lessonId, int chapterIndex) => "$lessonId:l:$chapterIndex";

  final String Function(String lessonId, int chapterIndex) stringify;

  const ChapterType(this.stringify);
}

extension<K, V> on Map<K, V> {
  Iterable<(K, V)> get pairs => entries.map((e) => (e.key, e.value));
}
