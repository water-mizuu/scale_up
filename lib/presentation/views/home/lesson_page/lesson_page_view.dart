import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_description.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_information.dart";

class LessonPageView extends StatelessWidget {
  const LessonPageView({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: lesson.color,
        foregroundColor: lesson.foregroundColor,
      ),
      body: InheritedProvider.value(
        value: lesson,
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [LessonDescription(), Expanded(child: LessonInformation())],
        ),
      ),
    );
  }
}
