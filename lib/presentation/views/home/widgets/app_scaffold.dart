import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
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
    HapticFeedback.selectionClick();

    switch (index) {
      case 0:
        if (kDebugMode) {
          print("Going to home as clicked on the navbar.");
        }
        context.goNamed(AppRoutes.home);
        break;
      case 1:
        if (kDebugMode) {
          print("Going to all lessons as clicked on the navbar.");
        }
        context.goNamed(AppRoutes.allLessons);
        break;
      case 2:
        if (kDebugMode) {
          print("Going to profile as clicked on the navbar.");
        }
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
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _changeTab,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: "Lessons"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Help"),
        ],
      ),
    );
  }
}
