import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String message = "";
      switch (e.code) {
        case "weak-password":
          message = "The password is too weak. Please try a stronger one!";
          break;
        case "email-already-in-use":
          message =
              "The email is already connected with another account. Please try another email.";
          break;
        case "invalid-email":
          message =
              "The email address is not valid. Please check and try again.";
          break;
        case "operation-not-allowed":
          message =
              "Email/password accounts are not enabled. Please contact support.";
          break;
        case "network-request-failed":
          message =
              "A network error occurred. Please check your connection and try again.";
          break;
        default:
          message = "An unknown error occurred. Please try again.";
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// throws [PlatformException]
  Future<UserCredential?> googleSignIn() async {
    // try {
    // await _googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
    // } catch (e) {
    //   Fluttertoast.showToast(
    //     msg: "Google Sign-In Successful!",
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.SNACKBAR,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //   );
    //   return null;
    // }
  }
}
