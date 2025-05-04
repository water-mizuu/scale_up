import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/fade_slide_in.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";

class FloatingCardWithHint extends StatelessWidget {
  const FloatingCardWithHint({
    super.key,
    required this.hint,
    required this.child,
    required this.isRetry,
  });

  final String hint;
  final Widget child;
  final bool isRetry;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        spacing: 4.0,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Styles.hint(hint),
              if (isRetry)
                Styles.hint(
                  "Another Try!",
                  color: Colors.redAccent,
                ).animate().then(delay: 1000.ms).slideFadeIn(),
            ],
          ),
          Flexible(child: FloatingCard(child: child)),
        ],
      ),
    );
  }
}

class FloatingCard extends StatelessWidget {
  const FloatingCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.white.borderColor),
      ),
      child: child,
    );
  }
}
