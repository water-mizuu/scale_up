import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/views/authentication/widgets/lesson_tile.dart";

class LessonTileColored extends StatelessWidget {
  const LessonTileColored({super.key});

  @override
  Widget build(BuildContext context) {
    var LessonTileProps(:baseColor, :icon) = context.read();

    return Container(
      padding: const EdgeInsets.all(8.0) + const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [
            baseColor,
            baseColor.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(icon, color: Colors.white, size: 18.0),
      ),
    );
  }
}
