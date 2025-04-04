import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile.dart";

class FeaturedLesson extends StatelessWidget {
  const FeaturedLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<LessonsRepository>().lessons,
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

        final lessons = snapshot.data!;

        return LessonTile(lesson: lessons.first);
      },
    );
  }
}
