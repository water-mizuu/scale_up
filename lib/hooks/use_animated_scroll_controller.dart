import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:scroll_animator/scroll_animator.dart";

/// Creates [AnimatedScrollController] that will be disposed automatically.
///
/// See also:
/// - [AnimatedScrollController]
AnimatedScrollController useAnimatedScrollController({
  ScrollAnimationFactory animationFactory = const ChromiumImpulse(),
  double initialScrollOffset = 0.0,
  bool keepScrollOffset = true,
  String? debugLabel,
  List<Object?>? keys,
}) {
  return use(
    _AnimatedScrollControllerHook(
      animationFactory: animationFactory,
      initialScrollOffset: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      debugLabel: debugLabel,
      keys: keys,
    ),
  );
}

class _AnimatedScrollControllerHook extends Hook<AnimatedScrollController> {
  const _AnimatedScrollControllerHook({
    required this.animationFactory,
    required this.initialScrollOffset,
    required this.keepScrollOffset,
    this.debugLabel,
    super.keys,
  });

  final ScrollAnimationFactory animationFactory;
  final double initialScrollOffset;
  final bool keepScrollOffset;
  final String? debugLabel;

  @override
  HookState<AnimatedScrollController, Hook<AnimatedScrollController>> createState() =>
      _ScrollControllerHookState();
}

class _ScrollControllerHookState
    extends HookState<AnimatedScrollController, _AnimatedScrollControllerHook> {
  late final controller = AnimatedScrollController(
    animationFactory: hook.animationFactory,
    initialScrollOffset: hook.initialScrollOffset,
    keepScrollOffset: hook.keepScrollOffset,
    debugLabel: hook.debugLabel,
  );

  @override
  AnimatedScrollController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => "useScrollController";
}
