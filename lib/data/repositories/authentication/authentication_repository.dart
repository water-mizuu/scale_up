import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:scale_up/firebase_auth/firebase_authentication.dart';

final class AuthenticationRepository {
  // Future<User?> signIn({required String username, required String password});

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

  Future<void> emailSignIn({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential?> googlSignIn() => UserAuth().googleSignIn();

  Future<void> signOut() => FirebaseAuth.instance.signOut();
}
