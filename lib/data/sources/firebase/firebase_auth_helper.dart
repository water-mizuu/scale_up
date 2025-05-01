import "dart:convert";
import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:google_sign_in/google_sign_in.dart" as other;
import "package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart" as win;

abstract class FirebaseAuthHelper {
  factory FirebaseAuthHelper() {
    if (!kIsWeb && Platform.isWindows) {
      return _FirebaseAuthHelperWindows();
    } else {
      return _FirebaseAuthHelperNotWindows();
    }
  }

  Stream<User?> get authStateChanges;

  Future<User?> emailSignUp({
    required String email,
    required String password,
    required String username,
  });

  Future<void> signOut();
  Future<User?> googleSignIn();
  Future<User?> emailSignIn({required String email, required String password});
}

class _FirebaseAuthHelperWindows implements FirebaseAuthHelper {
  win.GoogleSignIn? _googleSignIn;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// FirebaseAuthHelperNotWindows

  /// throws [FirebaseAuthException]
  @override
  Future<User?> emailSignUp({
    required String email,
    required String password,
    required String username,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    var googleSignIn = await _getGoogleSignIn();
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  /// throws [PlatformException]
  @override
  Future<User?> googleSignIn() async {
    var googleSignIn = await _getGoogleSignIn();
    var googleAuth = await googleSignIn.signIn();

    /// This can be null if the user cancels the sign-in.
    if (googleAuth == null) return null;

    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var userCredentials = await _auth.signInWithCredential(credential);

    return userCredentials.user;
  }

  @override
  Future<User?> emailSignIn({required String email, required String password}) async {
    var userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }

  Future<win.GoogleSignIn> _getGoogleSignIn() async {
    if (_googleSignIn case win.GoogleSignIn googleSignIn) {
      return googleSignIn;
    }

    if (Platform.isWindows) {
      var jsonString = await rootBundle.loadString("secrets/windows.json");
      var decoded = jsonDecode(jsonString);

      if (decoded case {
        "installed": {"client_id": String clientId, "client_secret": String clientSecret},
      }) {
        _googleSignIn = win.GoogleSignIn(
          params: win.GoogleSignInParams(clientId: clientId, clientSecret: clientSecret),
        );

        return _googleSignIn!;
      } else {
        if (kDebugMode) {
          print("Failed to load windows secrets as it didn't match the pattern.");
          print(decoded);
        }
      }
    } else if (Platform.isAndroid) {
      var jsonString = await rootBundle.loadString("secrets/android.json");

      if (jsonDecode(jsonString) case {
        "web": {"client_id": String clientId, "client_secret": String clientSecret},
      }) {
        _googleSignIn = win.GoogleSignIn(
          params: win.GoogleSignInParams(clientId: clientId, clientSecret: clientSecret),
        );

        return _googleSignIn!;
      }
    }

    throw UnsupportedError("Failed loading the client secret.");
  }
}

class _FirebaseAuthHelperNotWindows implements FirebaseAuthHelper {
  final other.GoogleSignIn _googleSignIn = other.GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// FirebaseAuthHelperNotWindows

  /// throws [FirebaseAuthException]
  @override
  Future<User?> emailSignUp({
    required String email,
    required String password,
    required String username,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// throws [PlatformException]
  @override
  Future<User?> googleSignIn() async {
    var googleUser = await _googleSignIn.signIn();

    /// This can be null if the user cancels the sign-in.
    if (googleUser == null) return null;

    var googleAuth = await googleUser.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var userCredentials = await _auth.signInWithCredential(credential);

    return userCredentials.user;
  }

  @override
  Future<User?> emailSignIn({required String email, required String password}) async {
    var userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }
}
