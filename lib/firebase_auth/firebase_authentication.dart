import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserAuth {
  Future<void> signup({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
}
