import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:scale_up/firebase/firebase_authentication.dart";
import "package:scale_up/firebase/firebase_firestore.dart";

final class AuthenticationRepository {
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  Future<User?> emailSignUp({
    required String username,
    required String email,
    required String password,
  }) async {
    var credentials = await UserAuth().signUp(
      username: username,
      email: email,
      password: password,
    );

    if (credentials.user case User user) {
      await UserDb.attemptToRegisterUser(user);
    }

    return credentials.user;
  }

  Future<User?> emailSignIn({
    required String email,
    required String password,
  }) async {
    var credentials = await UserAuth().emailSignIn(
      email: email,
      password: password,
    );

    if (credentials.user case User user) {
      await UserDb.attemptToRegisterUser(user);
    }

    return credentials.user;
  }

  Future<User?> googleSignIn() async {
    var credentials = await UserAuth().googleSignIn();

    if (credentials?.user case User user) {
      await UserDb.attemptToRegisterUser(user);
    }


    return credentials?.user;
  }

  Future<void> signOut() async {
    await UserAuth().signOut();
  }
}
