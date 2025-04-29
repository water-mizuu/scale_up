import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/border_color.dart";

class FloatingCardWithHint extends StatelessWidget {
  const FloatingCardWithHint({super.key, required this.hint, required this.child});

  final String hint;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.0,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Styles.hint("Answer the question:"), FloatingCard(child: child)],
    );
  }
}

class FloatingCard extends StatelessWidget {
  const FloatingCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.white.borderColor),
      ),
      child: Column(
        spacing: 10.0,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [child],
      ),
    );
  }
}
