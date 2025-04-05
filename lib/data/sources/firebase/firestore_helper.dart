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

  Future<Set<String>> getCompletedChapters({required User user}) async {
    var userDoc = await _createUserDocumentIfNotExists(user);
    var completedChapters = await userDoc //
        .get()
        .then((d) => d.data()!["completed_chapters"]! as List<Object?>)
        .then((l) => l.whereType<String>().toSet());

    return completedChapters;
  }

  static Timer? _registerDebounce;
  static final _registerQueue = Queue<(String, int)>();
  Future<void> registerChapterAsCompletedAsync(User user, String lessonId, int chapterIndex) async {
    _registerQueue.add((lessonId, chapterIndex));

    if (_registerDebounce?.isActive ?? false) {
      _registerDebounce?.cancel();
    }

    _registerDebounce = Timer(Duration(seconds: 1), () async {
      var userDoc = await _createUserDocumentIfNotExists(user);
      var completedChapters = await userDoc.get().then((d) => d.data()!["completed_chapters"]!);
      if (completedChapters case List completedChapters) {
        for (var (lessonId, chapterIndex) in _registerQueue) {
          var key = "$lessonId:$chapterIndex";
          if (completedChapters.contains(key)) continue;

          completedChapters.add(key);
        }

        await userDoc.update({"completed_chapters": completedChapters});
        _registerQueue.clear();
      }
    });
  }

  Future<DocumentReference<Map<String, Object?>>> _createUserDocumentIfNotExists(User user) async {
    var userDoc = _userCollection.doc(user.uid);
    if (await userDoc.get().then((d) => !d.exists)) {
      await userDoc.set({
        "uid": user.uid,
        "completed_chapters": [],
        "createdAt": FieldValue.serverTimestamp(),
      });
    }

    return _userCollection.doc(user.uid);
  }
}
