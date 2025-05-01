import "package:flutter/material.dart";

class BlankLessonPage extends StatelessWidget {
  const BlankLessonPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, scrolledUnderElevation: 0.0, title: Text("Lesson page")),
      body: Center(child: Text("Lesson not found '$id'")),
    );
  }
}
