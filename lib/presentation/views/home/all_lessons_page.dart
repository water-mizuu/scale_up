import "package:flutter/material.dart" hide SearchBar;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";
import "package:scale_up/presentation/bloc/LessonsPage/lessons_page_cubit.dart";
import "package:scale_up/presentation/views/home/lesson_body.all_lessons_page.dart";
import "package:scale_up/presentation/views/home/search_bar.all_lessons_page.dart";
import "package:scale_up/presentation/views/home/title_bar.all_lessons_page.dart";

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<LessonsRepository>().lessons,
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
        if (lessons.isEmpty) {
          return const Center(
            child: Text("No lessons available"),
          );
        }
        return BlocProvider(
          create: (context) => LessonsPageCubit(lessons),
          child: LessonsPageView(),
        );
      },
    );
  }
}

class LessonsPageView extends StatelessWidget {
  const LessonsPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
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
                children: [
                  SearchBar(),
                  Expanded(child: LessonBody()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
