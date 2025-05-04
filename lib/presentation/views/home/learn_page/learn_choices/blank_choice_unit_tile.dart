import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";

class BlankChoiceUnitTile extends StatelessWidget {
  const BlankChoiceUnitTile({super.key, required this.unit});

  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: borderRadius,
          border: Border.all(color: Colors.grey[200]!.borderColor),
        ),
        padding: const EdgeInsets.all(8.0) + const EdgeInsets.symmetric(horizontal: 8.0),
        child: Opacity(
          opacity: 0.0,
          child: Text(unit.shortcut, style: GoogleFonts.notoSansMath()),
        ),
      ),
    );
  }
}
