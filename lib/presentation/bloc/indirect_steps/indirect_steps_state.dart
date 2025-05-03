import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";

part "indirect_steps_state.freezed.dart";

enum IndirectStepsStatus { idle, animating }

@freezed
sealed class IndirectStepsState with _$IndirectStepsState {
  const IndirectStepsState._();

  const factory IndirectStepsState.blank() = BlankIndirectStepsState;
  const factory IndirectStepsState.active({
    required IndirectStepsLearnQuestion question,
    required IndirectStepsStatus status,
    required List<(int choiceIndex, Unit unit)?> answers,
    required List<Unit?> choices, //
    required AnimationController animationController,
    required GlobalKey parentKey,
    required List<GlobalKey> answerKeys,
    required List<GlobalKey> choiceKeys,
    required (Unit, Offset, Offset)? animation,
  }) = ActiveIndirectStepsState;
}
