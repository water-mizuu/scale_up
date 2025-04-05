import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

class FirebaseAuthHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// throws [FirebaseAuthException]
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

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// throws [PlatformException]
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

  Future<User?> emailSignIn({required String email, required String password}) async {
    var userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }
}
