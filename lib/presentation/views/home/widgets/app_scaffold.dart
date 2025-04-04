import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/router/app_router.dart";

class AppScaffold extends StatefulWidget {
  final Widget? child;

  const AppScaffold({super.key, this.child});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int currentIndex = 0;

  void _changeTab(int index) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.home);
        break;
      case 1:
        context.goNamed(AppRoutes.allLessons);
        break;
      case 2:
        context.goNamed(AppRoutes.profile);
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _changeTab,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
