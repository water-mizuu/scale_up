import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/border_color.dart";

class NewLessonTile extends StatefulWidget {
  const NewLessonTile({
    super.key,
    required this.lesson,
    this.onTap = _blank,
    this.isHighlighted = false,
    this.isSmall = false,
  });

  final Lesson lesson;
  final VoidCallback? onTap;
  final bool isHighlighted;
  final bool isSmall;

  /// This is a blank function that does nothing.
  ///   It is used as a default value for the onTap parameter.
  ///   This is useful when you want to pass a function that does nothing
  ///   as a default value for a parameter.
  static Never _blank() {
    throw StateError("onTap function is not defined");
  }

  @override
  State<NewLessonTile> createState() => _NewLessonTileState();
}

class _NewLessonTileState extends State<NewLessonTile> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<double>? scaleAnimation;

  ({Color foreground, Color background, Color progressBackground}) getColors() {
    var lessonColor = widget.lesson.color;
    var hslColor = widget.lesson.hslColor;

    var foregroundColor = widget.isHighlighted ? Colors.white : lessonColor;
    var backgroundColor = widget.isHighlighted ? lessonColor : Colors.white;
    var progressBackgroundColor =
        widget
                .isHighlighted //
            ? hslColor.withLightness(hslColor.lightness * 0.8).toColor()
            : Colors.grey;

    return (
      foreground: foregroundColor,
      background: backgroundColor,
      progressBackground: progressBackgroundColor,
    );
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: 500.ms);
    scaleAnimation = AlwaysStoppedAnimation(1.0);
  }

  @override
  Widget build(BuildContext context) {
    var lessonsHelper = context.read<LessonsHelper>();
    var totalChapters = widget.lesson.chapterCount;
    var (:foreground, :background, :progressBackground) = getColors();

    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
              decoration: BoxDecoration(
                color: HSLColor.fromColor(foreground).withLightness(0.9).toColor(),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Styles.title(
                widget.lesson.name.characters.first.toUpperCase(),
                color: foreground,
              ),
            ),
            const SizedBox(width: 8.0),
            Styles.subtitle(widget.lesson.name, fontSize: 14, color: foreground),
          ],
        ),

        const SizedBox(height: 4.0),
        Styles.caption(
          "Learn about ${widget.lesson.units.map((u) => lessonsHelper.getUnit(u)?.shortcut ?? u).join(", ")}.",
          fontSize: 12.0,
        ),

        const SizedBox(height: 8.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Styles.hint("$totalChapters chapters", fontSize: 12),
            Container(
              height: 32.0,
              decoration: BoxDecoration(
                color: HSLColor.fromColor(foreground).withLightness(0.9).toColor(),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Icon(Icons.keyboard_arrow_right, color: foreground),
              ),
            ),
          ],
        ),
      ],
    );

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          scaleAnimation = CurvedAnimation(
            curve: Curves.elasticOut,
            parent: animationController,
          ).drive(Tween(begin: 1.0, end: 0.98));
          animationController.forward(from: 0.0);
        });
      },
      onTapCancel: () {
        setState(() {
          scaleAnimation = CurvedAnimation(
            curve: Curves.elasticOut,
            parent: animationController,
          ).drive(Tween(begin: 0.98, end: 1.0));
          animationController.forward(from: 0.0);
        });
      },
      onTapUp: (_) {
        setState(() {
          scaleAnimation = CurvedAnimation(
            curve: Curves.elasticOut,
            parent: animationController,
          ).drive(Tween(begin: 0.98, end: 1.0));
          animationController.reverse(from: 1.0);
        });
      },
      onTap: () {
        if (widget.onTap == NewLessonTile._blank) {
          return () {
            HapticFeedback.selectionClick();

            context.pushNamed(AppRoutes.lesson, pathParameters: {"id": widget.lesson.id});
          };
        }

        return widget.onTap;
      }(),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.scale(scale: scaleAnimation?.value ?? 1.0, child: child!);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [background, background.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white.borderColor),
          ),
          child: child,
        ),
      ),
    );
  }
}
