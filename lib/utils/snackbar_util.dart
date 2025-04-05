import "package:flutter/material.dart";

extension SnackbarExtension on BuildContext {
  Future<void> showBasicSnackbar(String message) async {
    var snackBar = SnackBar(content: Text(message), duration: Duration(milliseconds: 500));

    await ScaffoldMessenger.of(this).showSnackBar(snackBar).closed;
  }
}
