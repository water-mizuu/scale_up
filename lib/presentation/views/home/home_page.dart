import "package:flutter/material.dart" hide SearchBar;
import "package:scale_up/presentation/views/home/explore_lesson_container.home_page.dart";
import "package:scale_up/presentation/views/home/featured_lessons_container.home_page.dart";
import "package:scale_up/presentation/views/home/ongoing_lessons_container.home_page.dart";
import "package:scale_up/presentation/views/home/search_bar.home_page.dart";
import "package:scale_up/presentation/views/home/user_bar.home_page.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            UserBar(),
            Expanded(
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SearchBar(),
                  FeaturedLessonsContainer(),
                  OngoingLessonsContainer(),
                  ExploreLessonsContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
