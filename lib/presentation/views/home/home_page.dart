import "package:flutter/material.dart" hide SearchBar;
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/home_page/home_page_cubit.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/home_page/latest_lesson.dart";
import "package:scale_up/presentation/views/home/home_page/statistics.dart";
import "package:scale_up/presentation/views/home/home_page/user_bar.dart";
import "package:scale_up/presentation/views/home/widgets/lesson_tile/new_lesson_tile.dart";
import "package:scale_up/presentation/views/home/widgets/lesson_tile/ongoing_lesson_tile.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animated_scroll_controller.dart";
import "package:scale_up/utils/extensions/batch_extension.dart";
import "package:scale_up/utils/extensions/fade_slide_in.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = HomePageCubit(
      state: context.read<UserDataBloc>().state,
      lessonsHelper: context.read<LessonsHelper>(),
    );
  }

  @override
  void dispose() {
    cubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userDataBloc = context.read<UserDataBloc>();

    return MultiProvider(
      providers: [BlocProvider.value(value: cubit)],
      builder: (context, _) {
        return MultiBlocListener(
          listeners: [
            BlocListener<UserDataBloc, UserDataState>(
              bloc: userDataBloc,
              listener: (context, state) {
                var homePageCubit = context.read<HomePageCubit>();

                homePageCubit.updateFinishedChaptersString(state.finishedChapters);
                homePageCubit.updateStatistics(
                  totalTimeInLessons: state.totalTimeInLessons,
                  chaptersFinished: state.finishedChapters.length,
                  correctAnswers: state.correctAnswers,
                  totalAnswers: state.totalAnswers,
                );
              },
            ),
          ],
          child: const HomePageView(),
        );
      },
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with SingleTickerProviderStateMixin {
  late final AnimatedScrollController scrollController;
  late final AnimationController animationController;
  late ValueKey<int> listKey;

  @override
  void initState() {
    super.initState();

    scrollController = AnimatedScrollController();
    animationController = AnimationController(vsync: this);
    listKey = const ValueKey(0);
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true, elevation: 0, scrolledUnderElevation: 0),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(500.ms);
            setState(() {
              listKey = ValueKey(listKey.value + 1);
            });
            await animationController.reverse(from: 0.8);
            animationController.reset();
          },
          child: KeyedSubtree(
            key: listKey,
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
                    children: [
                      NewLessons(), //
                      OngoingLessons(), //
                      FinishedLessons(),
                    ],
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

class NewLessons extends StatefulWidget {
  const NewLessons({super.key});

  @override
  State<NewLessons> createState() => _NewLessonsState();
}

class _NewLessonsState extends State<NewLessons> {
  late final AnimatedScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = AnimatedScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

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
