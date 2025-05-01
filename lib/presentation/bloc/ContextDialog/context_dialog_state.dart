import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "context_dialog_state.freezed.dart";

@freezed
sealed class ContextDialogState with _$ContextDialogState {
  const ContextDialogState._();

  const factory ContextDialogState.showingConfirmationDialog({
    required String title,
    required String message,
    @Default(Colors.blueAccent) Color confirmButtonColor,
    @Default(Colors.redAccent) Color cancelButtonColor,
    @Default("Confirm") String confirmButtonText,
    @Default("Cancel") String cancelButtonText,
    required void Function() onConfirmPressed,
    required void Function() onCancelPressed,
  }) = ShowConfirmationDialog;

  // const factory ContextDialogState.showingErrorDialog({
  //   required String title,
  //   required String message,
  //   required String buttonText,
  //   required Color buttonColor,
  //   required Function() onConfirmPressed,
  // }) = ShowErrorDialog;

  const factory ContextDialogState.showingInfoDialog({
    required String title,
    required String message,
    required String buttonText,
    required Color buttonColor,
    required Function() onPressed,
  }) = ShowInfoDialog;

  const factory ContextDialogState.hidden() = HiddenConfirmationDialog;
}
