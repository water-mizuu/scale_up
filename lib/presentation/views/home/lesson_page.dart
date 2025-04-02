import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/presentation/views/widgets/unit_tile.dart";
import "package:scroll_animator/scroll_animator.dart";

class LessonPage extends StatelessWidget {
  const LessonPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    var lessonRepository = context.read<LessonsRepository>();

    return FutureBuilder(
      future: lessonRepository[id],
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snapshot.error.toString()),
              duration: const Duration(seconds: 2),
            ),
          );
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        assert(snapshot.hasData);
        switch (snapshot.data) {
          case Lesson lesson:
            return LessonPageView(lesson: lesson);
          case null:
            return BlankLessonPage(id: id);
        }
      },
    );
  }
}

class BlankLessonPage extends StatelessWidget {
  const BlankLessonPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        title: Text("Lesson page"),
      ),
      body: Center(
        child: Text("Lesson not found '$id'"),
      ),
    );
  }
}

class LessonPageView extends StatelessWidget {
  const LessonPageView({
    required this.lesson,
    super.key,
  });

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: lesson.color,
            ),
            child: Column(
              spacing: 4.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Styles.title(
                  lesson.name,
                  style: TextStyle(color: lesson.foregroundColor),
                ),
                Styles.body(
                  lesson.description,
                  style: TextStyle(color: lesson.foregroundColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: Provider.value(
              value: lesson,
              child: LessonInformation(),
            ),
          ),
        ],
      ),
    );
  }
}

class LessonInformation extends StatelessWidget {
  const LessonInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AnimatedScrollController(animationFactory: const ChromiumEaseInOut()),
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              spacing: 8.0,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Styles.subtitle("Units Involved"),
                Column(
                  spacing: 4.0,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var unit in context.read<Lesson>().units)
                    UnitTile(unit: unit),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
