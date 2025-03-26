import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:scale_up/firebase_auth/firebase_authentication.dart';

abstract class AuthenticationRepository {
  // Future<User?> logIn({required String username, required String password});

  Future<void> loginEmailPassword({
    required String email,
    required String password,
  });

  Future<void> loginGoogle();

  Future<void> logOut();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<UserCredential> loginEmailPassword({
    required String email,
    required String password,
  }) =>
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserCredential?> loginGoogle() => UserAuth().googleSignIn();

  @override
  Future<void> logOut() => UserAuth().signOut();
}
