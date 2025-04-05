import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

const TextStyle mini = TextStyle(fontSize: 12);

class UnitTile extends StatefulWidget {
  const UnitTile({required this.unit, super.key});

  final String unit;

  @override
  State<UnitTile> createState() => _UnitTileState();
}

class _UnitTileState extends State<UnitTile> {
  late final Future<Unit?> unitFuture;

  @override
  void initState() {
    super.initState();

    unitFuture = context.read<LessonsHelper>().getUnit(widget.unit);
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));

    return FutureBuilder(
      future: unitFuture,
      builder: (context, snapshot) {
        return Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
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
          child: InkWell(
            borderRadius: borderRadius,
            // onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (snapshot.data case Unit(:var shortcut)) Styles.title(shortcut),
                  FittedBox(fit: BoxFit.scaleDown, child: Text(widget.unit)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
