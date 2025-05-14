import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices.dart";

class ChoiceUnitTile extends StatelessWidget {
  const ChoiceUnitTile({super.key, required this.unit, this.onTap});

  final Unit unit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var hslColor = context.select((LearnPageBloc b) => b.loadedState.lesson.hslColor);
    var backgroundColor =
        hslColor //
            .withSaturation(hslColor.saturation * 0.8)
            .withLightness(0.95)
            .toColor();

    var borderColor =
        hslColor //
            .withSaturation(hslColor.saturation * 0.8)
            .withLightness(0.75)
            .toColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor),
        ),
        padding: padding,
        child: Text(unit.shortcut, style: GoogleFonts.notoSansMath()),
        //
      ),
    );
  }
}
