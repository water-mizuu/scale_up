import "package:flutter/material.dart" hide SearchBar;
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/HomePage/home_page_cubit.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/home_page/latest_lesson_container.dart";
import "package:scale_up/presentation/views/home/home_page/statistics.dart";
import "package:scale_up/presentation/views/home/home_page/user_bar.dart";
import "package:scale_up/presentation/views/home/widgets/newer_lesson_tile.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animated_scroll_controller.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var userDataBloc = context.read<UserDataBloc>();
    return MultiProvider(
      providers: [
        BlocProvider(
          create:
              (_) => HomePageCubit(
                finishedChaptersString: userDataBloc.state.finishedChapters,
                lessonsHelper: context.read<LessonsHelper>(),
              ),
        ),
      ],
      builder: (context, _) {
        return BlocListener<UserDataBloc, UserDataState>(
          bloc: userDataBloc,
          listener: (context, state) {
            context.read<HomePageCubit>().updateFinishedChaptersString(state.finishedChapters);
          },
          child: HomePageView(),
        );
      },
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true, elevation: 0, scrolledUnderElevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            UserBar(),
            Expanded(
              child: InheritedProvider(
                create: (_) => AnimatedScrollController(),
                builder: (context, child) {
                  return SingleChildScrollView(
                    controller: context.read<AnimatedScrollController>(),
                    physics: const BouncingScrollPhysics(),
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    spacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LatestLessonContainer(),
                      Statistics(),
                      OngoingLessons(),
                      NewLessons(),
                      FinishedLessons(),
                      // OngoingLessonsContainer(),
                      // ExploreLessonsContainer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OngoingLessons extends StatelessWidget {
  const OngoingLessons({super.key});

  @override
  Widget build(BuildContext context) {
    var ongoingLessons = context.select((HomePageCubit cubit) => cubit.state.ongoingLessons);

    if (ongoingLessons.isEmpty) {
      return const SizedBox.shrink();
    }

    var child = Column(
      spacing: 4.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Styles.hint("Continue your other lessons!"),
        Column(
          spacing: 16.0,
          children: [
            for (var (i, lesson) in ongoingLessons.indexed)
              if (NewerLessonTile(lesson: lesson) case var widget)
                widget.animate().then(delay: (i * 100).ms).slideFadeIn(),
          ],
        ),
      ],
    );

    return child;
  }
}

class NewLessons extends StatelessWidget {
  const NewLessons({super.key});

  @override
  Widget build(BuildContext context) {
    var newLessons = context.select((HomePageCubit cubit) => cubit.state.newLessons);

    if (newLessons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      spacing: 4.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Styles.hint("Explore these lessons!"),
        Column(
          spacing: 16.0,
          children: [
            for (var (i, lesson) in newLessons.indexed)
              if (NewerLessonTile(lesson: lesson) case var widget)
                widget.animate().then(delay: (i * 100).ms).slideFadeIn(),
          ],
        ),
      ],
    );
  }
}

class FinishedLessons extends StatelessWidget {
  const FinishedLessons({super.key});

  @override
  Widget build(BuildContext context) {
    var finishedLessons = context.select((HomePageCubit cubit) => cubit.state.finishedLessons);

    if (finishedLessons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      spacing: 4.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Styles.hint("You can also review these you have finished."),
        Column(
          spacing: 16.0,
          children: [
            for (var (i, lesson) in finishedLessons.indexed)
              if (NewerLessonTile(lesson: lesson) case var widget)
                widget.animate().then(delay: (i * 100).ms).slideFadeIn(),
          ],
        ),
      ],
    );
  }
}

extension on Animate {
  Animate slideFadeIn() {
    return fadeIn().slideY(
      begin: -0.1,
      end: 0.0,
      duration: 500.ms,
      curve: Curves.linearToEaseOut,
    );
  }
}
