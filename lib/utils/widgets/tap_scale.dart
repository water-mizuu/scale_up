import "package:flutter/material.dart";
import "package:provider/single_child_widget.dart";
import "package:scale_up/utils/extensions/num_duration_extension.dart";

class TapScale extends SingleChildStatefulWidget {
  const TapScale({super.key, super.child});

  @override
  State<TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends SingleChildState<TapScale> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: 300.ms);
    scaleAnimation = const AlwaysStoppedAnimation(1.0);
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  void _tapDown() {
    setState(() {
      scaleAnimation = CurvedAnimation(
        curve: Curves.easeOut,
        parent: animationController,
      ).drive(Tween(begin: 1.0, end: 0.95));

      animationController
        ..duration = 250.ms
        ..forward(from: 0.0);
    });
  }

  void _tapUp() {
    setState(() {
      scaleAnimation = CurvedAnimation(
        curve: Curves.elasticOut,
        parent: animationController,
      ).drive(Tween(begin: 0.95, end: 1.0));

      animationController
        ..duration = 500.ms
        ..forward(from: 0.0);
    });
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => _tapDown(),
      onTapCancel: () => _tapUp(),
      onTapUp: (_) => _tapUp(),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.scale(scale: scaleAnimation.value, child: child!);
        },
        child: child,
      ),
    );
  }
}
