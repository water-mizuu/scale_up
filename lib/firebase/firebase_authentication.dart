import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

class UserAuth {
  // Singleton
  UserAuth._internal();
  factory UserAuth() => _instance;
  static final UserAuth _instance = UserAuth._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// throws [FirebaseAuthException]
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // User? user = userCredential.user;
    // if (user != null) {
    //   await user.updateDisplayName(username);
    //   await user.reload();
    // }

    return userCredential;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// throws [PlatformException]
  Future<UserCredential?> googleSignIn() async {
    var googleUser = await _googleSignIn.signIn();

    /// This can be null if the user cancels the sign-in.
    if (googleUser == null) return null;

    var googleAuth = await googleUser.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential> emailSignIn({
    required String email,
    required String password,
  }) async {
    var userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }
}
