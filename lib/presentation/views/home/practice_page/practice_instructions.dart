import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_state.dart";
import "package:scale_up/presentation/views/home/widgets/floating_card.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/widgets/animated_slide_transition.dart";
import "package:scale_up/utils/widgets/tool_tip.dart";

class PracticeInstructions extends StatelessWidget {
  const PracticeInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    var LoadedPracticePageState(:questions, :questionIndex) = context //
        .select((PracticePageBloc bloc) => bloc.loadedState);

    var (left, right, number, steps, :isRetry) = questions[questionIndex];

    return AnimatedSlideTransition(
      child: FloatingCardWithHint(
        isRetry: isRetry,
        hint: "Do the computation:",
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              runAlignment: WrapAlignment.center,
              children: [
                Styles.subtitle("Convert the unit from "),
                Styles.subtitle("${left.name} ", fontWeight: FontWeight.bold),
                Styles.subtitle(
                  "(${left.shortcut})",
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.notoSansMath().fontFamily,
                ),
                Styles.subtitle(" to "),
                Styles.subtitle("${right.name} ", fontWeight: FontWeight.bold),
                Styles.subtitle(
                  "(${right.shortcut})",
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.notoSansMath().fontFamily,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Center(
                child: ToolTip(
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
                                const TextSpan(text: " From "),
                                TextSpan(
                                  text: from.shortcut,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(text: " to "),
                                TextSpan(
                                  text: to.shortcut,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(text: ":"),
                              ],
                            ),
                          ),

                          Styles.body(
                            "      "
                            "${to.shortcut} = ${expr.substituteString("from", from.shortcut)}",
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ],
                    ),
                  ),
                  child: Container(
                    /// There should be an underline under the text.
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Styles.title(
                      "$number ${left.shortcut} to ___ ${right.shortcut}?",
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
