import "package:flutter/material.dart";

extension SnackbarExtension on BuildContext {
  Future<void> showBasicSnackbar(String message) async {
    var snackBar = SnackBar(content: Text(message), duration: const Duration(milliseconds: 1000));

    await ScaffoldMessenger.of(this).showSnackBar(snackBar).closed;
  }
}
