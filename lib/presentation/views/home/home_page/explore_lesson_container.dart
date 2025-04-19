import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/HomePage/home_page_cubit.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile.dart";

class ExploreLessonsContainer extends StatelessWidget {
  const ExploreLessonsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var lessons = context.watch<HomePageCubit>().state.newLessons;

    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Explore New Lessons", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [for (var lesson in lessons) LessonTile(lesson: lesson)],
          ),
        ),
      ],
    );
  }
}
