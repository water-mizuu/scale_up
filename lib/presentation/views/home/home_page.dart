import "package:flutter/material.dart" hide SearchBar;
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/hooks/providing_hook_widget.dart";
import "package:scale_up/hooks/use_animated_scroll_controller.dart";
import "package:scale_up/hooks/use_bloc_listener.dart";
import "package:scale_up/presentation/bloc/home_page/home_page_cubit.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/home_page/latest_lesson.dart";
import "package:scale_up/presentation/views/home/home_page/statistics.dart";
import "package:scale_up/presentation/views/home/home_page/user_bar.dart";
import "package:scale_up/presentation/views/home/widgets/lesson_tile/new_lesson_tile.dart";
import "package:scale_up/presentation/views/home/widgets/lesson_tile/ongoing_lesson_tile.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/batch_extension.dart";
import "package:scale_up/utils/extensions/fade_slide_in.dart";

class HomePage extends ProvidingHookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var homePageCubit = useProvidedBloc(
      () => HomePageCubit(
        state: context.read<UserDataBloc>().state,
        lessonsHelper: context.read<LessonsHelper>(),
      ),
    );

    useBlocListener(context.read<UserDataBloc>(), (state) {
      homePageCubit
        ..updateFinishedChaptersString(state.finishedChapters)
        ..updateStatistics(
          totalTimeInLessons: state.totalTimeInLessons,
          chaptersFinished: state.finishedChapters.length,
          correctAnswers: state.correctAnswers,
          totalAnswers: state.totalAnswers,
        );
    });

    return const HomePageView();
  }
}

class HomePageView extends HookWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    var scrollController = useAnimatedScrollController();
    var animationController = useAnimationController();
    var listKey = useState(const ValueKey(0));

    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true, elevation: 0, scrolledUnderElevation: 0),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(1000.ms);
            listKey.value = ValueKey((listKey.value.value + 1) % 2);
            await animationController.reverse(from: 0.8);
            animationController.reset();
          },
          child: KeyedSubtree(
            key: listKey.value,
            child: ListView(
              controller: scrollController,
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: UserBar()),
                SizedBox(height: 12.0),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Statistics()),
                SizedBox(height: 12.0),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: LatestLesson()),
                SizedBox(height: 12.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    spacing: 16.0,
                    children: [NewLessons(), OngoingLessons(), FinishedLessons()],
                  ),
                ),
              ],
            ),
          ).animate(controller: animationController, autoPlay: false).fadeOut(begin: 1.0),
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
        Styles.subtitle("Continue your other lessons!", fontWeight: FontWeight.w600),
        Column(
          spacing: 16.0,
          children: [
            for (var (i, lesson) in ongoingLessons.indexed)
              if (OngoingLessonTile(lesson: lesson) case var widget)
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
        Styles.subtitle("Explore New Topics", fontWeight: FontWeight.w600),

        for (var batch in newLessons.batch(2))
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8.0,
              children: [
                for (var lesson in batch) //
                  Expanded(child: NewLessonTile(lesson: lesson)),
              ],
            ),
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
              if (OngoingLessonTile(lesson: lesson) case var widget)
                widget.animate().then(delay: (i * 200).ms).slideFadeIn(),
          ],
        ),
      ],
    );
  }
}
