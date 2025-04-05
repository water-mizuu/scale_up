import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile.dart";
import "package:scale_up/utils/snackbar_util.dart";

class FeaturedLesson extends StatefulWidget {
  const FeaturedLesson({super.key});

  @override
  State<FeaturedLesson> createState() => _FeaturedLessonState();
}

class _FeaturedLessonState extends State<FeaturedLesson> {
  late final Future<List<Lesson>> lessonsFuture;

  @override
  void initState() {
    super.initState();

    lessonsFuture = context.read<LessonsHelper>().lessons;
  }

  @override
  Widget build(BuildContext context) {
    (_) = context.watch<LessonsHelper>();

    return FutureBuilder(
      future: lessonsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          context.showBasicSnackbar(snapshot.error.toString());
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        assert(snapshot.hasData);

        final lessons = snapshot.data!;

        return LessonTile(lesson: lessons.last);
      },
    );
  }
}
