import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/router/app_router.dart";

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.pushNamed(AppRoutes.allLessonsSearch);
      },
      child: IgnorePointer(
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.search, size: 18),
            ),
            border: OutlineInputBorder(),
            hintText: "Search",
          ),
        ),
      ),
    );
  }
}
