import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:scale_up/firebase_auth/firebase_authentication.dart";

final class AuthenticationRepository {
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  Future<void> emailSignUp({
    required String username,
    required String email,
    required String password,
  }) async {
    await UserAuth().signUp(
      username: username,
      email: email,
      password: password,
    );
  }

  Future<User?> emailSignIn({
    required String email,
    required String password,
  }) async {
    var credentials = await UserAuth().emailSignIn(
      email: email,
      password: password,
    );

    return credentials.user;
  }

  Future<User?> googleSignIn() async {
    var credentials = await UserAuth().googleSignIn();

    return credentials?.user;
  }

  Future<void> signOut() async {
    await UserAuth().signOut();
  }
}
