import "package:flutter/material.dart";

class UnitTileWhite extends StatelessWidget {
  const UnitTileWhite({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        spacing: 20.0,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 110,
              maxWidth: 160,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
