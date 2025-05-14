import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/extensions/offset_extension.dart";

class AnimatedSlideTransition extends StatefulWidget {
  const AnimatedSlideTransition({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  final Widget child;
  final Duration delay;
  final Duration animationDuration;

  @override
  State<AnimatedSlideTransition> createState() => _AnimatedSlideTransitionState();
}

class _AnimatedSlideTransitionState extends State<AnimatedSlideTransition>
    with TickerProviderStateMixin {
  late final AnimationController _inTransitionController;
  late final AnimationController _outTransitionController;
  AnimationController? _inParentController;
  AnimationController? _outParentController;

  bool disposed = false;

  @override
  void initState() {
    super.initState();

    _inTransitionController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _outTransitionController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var transitionInAnimationController = context.read<TransitionInAnimationController>();
    if (_inParentController != transitionInAnimationController.controller) {
      _inParentController?.removeStatusListener(_inParentControllerListener);
      _inParentController = transitionInAnimationController.controller;
      _inParentController!.addStatusListener(_inParentControllerListener);

      _inParentControllerListener(_inParentController!.status);
    }

    var transitionOutAnimationController = context.read<TransitionOutAnimationController>();
    if (_outParentController != transitionOutAnimationController.controller) {
      _outParentController?.removeStatusListener(_outParentControllerListener);
      _outParentController = transitionOutAnimationController.controller;
      _outParentController!.addStatusListener(_outParentControllerListener);

      _outParentControllerListener(_outParentController!.status);
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedSlideTransition oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animationDuration != widget.animationDuration) {
      _inTransitionController.duration = widget.animationDuration;
      _outTransitionController.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    disposed = true;
    _inTransitionController.dispose();
    _outTransitionController.dispose();
    _inParentController?.removeStatusListener(_inParentControllerListener);
    _outParentController?.removeStatusListener(_outParentControllerListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _outTransitionController,
      builder: _animateFadeOut,
      child: AnimatedBuilder(
        animation: _inTransitionController,
        builder: _animateFadeIn,
        child: widget.child,
      ),
    );
  }

  void _inParentControllerListener(AnimationStatus status) async {
    if (status == AnimationStatus.forward) {
      /// We want a delay on our animation.
      if (disposed) return;
      await Future.delayed(widget.delay);
      if (disposed) return;
      await _inTransitionController.forward(from: 0.0);
    }
  }

  void _outParentControllerListener(AnimationStatus status) async {
    if (status == AnimationStatus.forward) {
      /// We want a delay on our animation.
      if (disposed) return;
      await Future.delayed(widget.delay);
      if (disposed) return;
      await _outTransitionController.forward(from: 0.0);
    }
  }

  Widget _animateFadeIn(BuildContext context, Widget? child) {
    var controller = _inTransitionController;

    var curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    Animation<Offset> slideAnimation;
    Animation<double> opacityAnimation;
    if (controller.status == AnimationStatus.completed) {
      slideAnimation = const AlwaysStoppedAnimation(Offset.zero);
      opacityAnimation = const AlwaysStoppedAnimation(1.0);
    } else {
      slideAnimation = Tween<Offset>(begin: 0.5.dx, end: 0.dx).animate(curve);
      opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    }

    return Opacity(
      opacity: opacityAnimation.value,
      child: FractionalTranslation(
        translation: slideAnimation.value, //
        child: child,
      ),
    );
  }

  Widget _animateFadeOut(BuildContext context, Widget? child) {
    var controller = _outTransitionController;

    var curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    Animation<Offset> slideAnimation;
    Animation<double> opacityAnimation;
    if (controller.isAnimating) {
      slideAnimation = Tween<Offset>(begin: 0.0.dx, end: -0.5.dx).animate(curve);
      opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(curve);
    } else {
      slideAnimation = const AlwaysStoppedAnimation(Offset.zero);
      opacityAnimation = const AlwaysStoppedAnimation(1.0);
    }

    return Opacity(
      opacity: opacityAnimation.value,
      child: FractionalTranslation(
        translation: slideAnimation.value, //
        child: child,
      ),
    );
  }
}
