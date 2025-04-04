import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";

class UserDb {
  UserDb._();

  static final _firestore = FirebaseFirestore.instance;
  static final _userCollection = _firestore.collection("users");

  /// This tries to put a user in the database.
  ///   This should be called when a user logs in.
  ///   If the user is already in the database, it will do nothing.
  static Future<void> attemptToRegisterUser(User user) async {
    try {
      var userDoc = _userCollection.doc(user.uid);
      if (await userDoc.get().then((d) => d.exists)) {
        // User already exists, do nothing
        return;
      }

      await userDoc.set({
        "uid": user.uid,
        "completed_chapters": [],
        "createdAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error adding user to Firestore: $e");
      }
    }
  }

  static Future<void> registerChapterAsCompleted(String lessonId, int chapterIndex) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    await attemptToRegisterUser(user);
    var userDoc = _userCollection.doc(user.uid);
    var completedChapters = await userDoc //
        .get()
        .then((d) => d.data()?["completed_chapters"] ?? []);

    if (completedChapters is List) {
      var key = "$lessonId:$chapterIndex"; // Replace with actual chapter ID
      if (completedChapters.contains(key)) return; // Already completed

      completedChapters.add("$lessonId:$chapterIndex"); // Replace with actual chapter ID
      await userDoc.update({"completed_chapters": completedChapters});
    }
  }
}
