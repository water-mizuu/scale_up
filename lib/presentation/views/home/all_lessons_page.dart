import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";
import "package:scale_up/presentation/bloc/LessonsPage/lessons_page_cubit.dart";
import "package:scale_up/presentation/views/authentication/widgets/lesson_tile.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonsPageCubit(context.read<LessonsRepository>().lessons),
      child: Scaffold(
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
      ),
    );
  }
}

class LessonBody extends StatelessWidget {
  const LessonBody({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LessonsPageCubit>().state;

    return SingleChildScrollView(
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var (key, value) in state.categoriesByTitle) //
            LessonGroup(
              categoryName: key,
              lessons: value,
            ),
        ],
      ),
    );
  }
}

class LessonGroup extends StatelessWidget {
  const LessonGroup({
    super.key,
    required this.categoryName,
    required this.lessons,
  });

  final String categoryName;
  final List<Lesson> lessons;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(categoryName, style: Styles.title),
        for (Lesson lesson in lessons)
          LessonTile(
            icon: Icons.check,
            label: lesson.name,
            sublabel: lesson.category,
            questionsDone: 0,
            questionsTotal: lesson.chapters.map((v) => v.questionCount).fold(0, (a, b) => a + b),
            baseColor: lesson.color,
          ),
      ],
    );
  }
}

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "All Lessons",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<LessonsPageCubit>().updateType(value),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.search,
            size: 18,
          ),
        ),
        border: OutlineInputBorder(),
        hintText: "Search",
      ),
    );
  }
}
