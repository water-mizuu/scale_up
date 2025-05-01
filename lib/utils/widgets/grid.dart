import "package:flutter/material.dart";

class Grid extends StatelessWidget {
  const Grid({super.key, required this.gridDelegate, this.children = const <Widget>[]});

  final SliverGridDelegate gridDelegate;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: GridView(
        gridDelegate: gridDelegate,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: children,
      ),
    );
  }
}
