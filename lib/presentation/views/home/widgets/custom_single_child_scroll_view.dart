import "package:flutter/material.dart";

class ScrollView extends StatefulWidget {
  const ScrollView({
    required this.child,
    this.scrollDirection = Axis.vertical,
    super.key,
  });

  final Axis scrollDirection;
  final Widget child;

  @override
  State<ScrollView> createState() => _ScrollViewState();
}

class _ScrollViewState extends State<ScrollView> {
  List<BoxShadow> shadow = [];

  BoxShadow get topShadow => const BoxShadow(
        color: Colors.grey,
        blurRadius: 5.0,
        offset: Offset(0.0, -8.0),
      );
  BoxShadow get bottomShadow => const BoxShadow(
        color: Colors.grey,
        blurRadius: 5.0,
        offset: Offset(0.0, 8.0),
      );

  bool handleNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    late List<BoxShadow> newShadow = [];
    if (metrics.extentBefore != 0.0) {
      // There is content before. Shadow on top.
      newShadow.add(topShadow);
    }
    if (metrics.extentAfter != 0.0) {
      // There is content after. Shadaow on bottom.
      newShadow.add(bottomShadow);
    }
    if (newShadow != shadow) {
      setState(() {
        shadow = newShadow;
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        boxShadow: shadow,
      ),
      child: NotificationListener<ScrollNotification>(
        onNotification: handleNotification,
        child: ListView.builder(
          itemBuilder: (_, index) => Container(
            color: Colors.amber[100],
            child: Text("Item $index"),
          ),
          itemCount: 50,
        ),
      ),
    );
  }
}
