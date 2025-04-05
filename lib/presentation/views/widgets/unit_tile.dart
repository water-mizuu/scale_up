import "package:flutter/material.dart";
import "package:scale_up/presentation/views/widgets/unit_tile/unit_tile_white.dart";

const TextStyle mini = TextStyle(fontSize: 12);

class UnitTile extends StatelessWidget {
  const UnitTile({
    required this.unit,
    super.key,
  });

  final String unit;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return Ink(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),

      /// This material widget makes sure that the ink doesn't overflow
      ///   through clipping like in scroll views.
      child: Material(
        /// The first ink handles the background color.
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
          ),
          child: InkWell(
            borderRadius: borderRadius,
            // onTap: () {},
            child: UnitTileWhite(name: unit),
          ),
        ),
      ),
    );
  }
}
