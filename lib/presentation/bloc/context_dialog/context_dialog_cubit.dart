import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/context_dialog/context_dialog_state.dart";

export "context_dialog_state.dart";

class ContextDialogCubit extends Cubit<ContextDialogState> {
  ContextDialogCubit() : super(const ContextDialogState.hidden());

  void showConfirmationDialog({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    void Function()? onConfirmPressed,
    void Function()? onCancelPressed,
  }) {
    emit(
      ContextDialogState.showingConfirmationDialog(
        title: title,
        message: message,
        confirmButtonText: confirmText ?? "Confirm",
        cancelButtonText: cancelText ?? "Cancel",
        confirmButtonColor: confirmButtonColor ?? Colors.blueAccent,
        cancelButtonColor: cancelButtonColor ?? Colors.redAccent,
        onConfirmPressed: () {
          onConfirmPressed?.call();
          hideDialog();
        },
        onCancelPressed: () {
          onCancelPressed?.call();
          hideDialog();
        },
      ),
    );
  }

  void hideDialog() {
    emit(const ContextDialogState.hidden());
  }

  void cancelDialogs() {
    if (state case ShowConfirmationDialog state) {
      state.onCancelPressed();
    }
  }
}
