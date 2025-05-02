import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/router/app_router.dart";

class AppScaffold extends HookWidget {
  const AppScaffold({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    var currentIndex = useState(0);

    void changeTab(int index) {
      HapticFeedback.selectionClick();

      switch (index) {
        case 0:
          if (kDebugMode) {
            print("Going to home as clicked on the navbar.");
          }
          currentIndex.value = 0;
          context.goNamed(AppRoutes.home);
          break;
        case 1:
          if (kDebugMode) {
            print("Going to all lessons as clicked on the navbar.");
          }
          currentIndex.value = 1;
          context.goNamed(AppRoutes.allLessons);
          break;
        case 2:
          if (kDebugMode) {
            print("Going to profile as clicked on the navbar.");
          }
          currentIndex.value = 2;
          context.goNamed(AppRoutes.profile);
          break;
      }
      currentIndex.value = index;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: changeTab,
        currentIndex: currentIndex.value,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: "Lessons"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Help"),
        ],
      ),
    );
  }
}
