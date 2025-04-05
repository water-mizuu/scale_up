import "package:flutter/material.dart" hide SearchBar;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/AllLessonsPage/all_lessons_page_cubit.dart";
import "package:scale_up/presentation/views/home/all_lessons_page/lesson_body.dart";
import "package:scale_up/presentation/views/home/all_lessons_page/search_bar.dart";
import "package:scale_up/presentation/views/home/all_lessons_page/title_bar.dart";
import "package:scale_up/utils/snackbar_util.dart";

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  late final Future<List<Lesson>> lessonsFuture;

  @override
  void initState() {
    super.initState();

    lessonsFuture = context.read<LessonsHelper>().lessons;
  }

  @override
  Widget build(BuildContext context) {
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
        if (lessons.isEmpty) {
          return const Center(child: Text("No lessons available"));
        }
        return BlocProvider(create: (_) => AllLessonsPageCubit(lessons), child: LessonsPageView());
      },
    );
  }
}

class LessonsPageView extends StatelessWidget {
  const LessonsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0.0, backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleBar(),
            Expanded(
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [SearchBar(), Expanded(child: LessonBody())],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
