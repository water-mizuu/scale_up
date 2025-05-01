import "package:scroll_animator/scroll_animator.dart" as animator;

/// An augmenting wrapper on the [animator.AnimatedScrollController] class.
final class AnimatedScrollController extends animator.AnimatedScrollController {
  AnimatedScrollController({
    super.initialScrollOffset = 0.0,
    super.keepScrollOffset = true,
    super.debugLabel,
    super.onAttach,
    super.onDetach,
  }) : super(animationFactory: const animator.ChromiumEaseInOut());
}
