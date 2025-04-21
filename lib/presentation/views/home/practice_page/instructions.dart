import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:super_tooltip/super_tooltip.dart";

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    var chapterPageBloc = context.read<PracticePageBloc>();
    var state = chapterPageBloc.state as LoadedPracticePageState;
    var LoadedPracticePageState(:questions, :questionIndex) = state;
    var (left, right, number, steps) = questions[questionIndex];

    var widget = Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Styles.subtitle(
            "Convert the unit from ${left.name} to ${right.name}",
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Center(
              child: SuperTooltip(
                barrierColor: Colors.transparent,
                /// IntrinsicWidth tells the Row to take the width of the widest child,
                ///   and impose that as a Constraint on the entire widget.
                content: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Styles.subtitle("Conversion steps"),

                      /// IntrinsicHeight tells the Row to take the height of the tallest child,
                      ///   and impose that as a Constraint on the entire widget.
                      for (var (i, ((from, to), expr)) in steps.indexed) ...[
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "${i + 1}."),
                              TextSpan(text: " From "),
                              TextSpan(
                                text: from.shortcut,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: " to "),
                              TextSpan(
                                text: to.shortcut,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ":"),
                            ],
                          ),
                        ),

                        Styles.body(
                          "      "
                          "${to.shortcut} = ${expr.substitute("from", VariableExpression(from.shortcut))}",
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ],
                  ),
                ),
                child: DottedBorder(
                  dashPattern: [4, 4],
                  customPath: (size) {
                    return Path()
                      ..moveTo(0, size.height)
                      ..lineTo(size.width, size.height);
                  },
                  child: Container(
                    /// There should be an underline under the text.
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Styles.title(
                      "$number ${left.shortcut} to ___ ${right.shortcut}?",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return widget
        .animate(
          controller: context.read<TransitionOutAnimationController>().controller,
          autoPlay: false,
        )
        .slideX(begin: 0.0, end: -0.5, curve: Curves.easeOutQuad)
        .fadeOut()
        .animate(
          controller: context.read<TransitionInAnimationController>().controller,
          autoPlay: false,
        )
        .slideX(begin: 0.5, end: 0.0, curve: Curves.easeOutQuad)
        .fadeIn();
  }
}
