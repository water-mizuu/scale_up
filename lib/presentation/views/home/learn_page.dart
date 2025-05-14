import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/hooks/providing_hook_widget.dart";
import "package:scale_up/hooks/use_bloc_builder.dart";
import "package:scale_up/hooks/use_bloc_listener.dart";
import "package:scale_up/presentation/bloc/indirect_steps/indirect_steps_cubit.dart";
import "package:scale_up/presentation/bloc/indirect_steps/indirect_steps_state.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/learn_page/completed_learn_body.dart";
import "package:scale_up/presentation/views/home/learn_page/congratulatory_message.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_body.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices/choice_unit_tile.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_congratulatory_barrier.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_continue_button.dart";
import "package:scale_up/presentation/views/home/notifications/user_quit_notification.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/extensions/snackbar_extension.dart";

class LearnPage extends StatefulWidget {
  const LearnPage({
    required this.lessonId,
    required this.chapterIndex,
    required this.isReview,
    super.key,
  });

  final String lessonId;
  final int chapterIndex;
  final bool isReview;

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> with TickerProviderStateMixin {
  late final LearnPageBloc learnPageBloc;
  late final IndirectStepsCubit indirectStepsCubit;
  late final AnimationController messageAnimation;
  late final AnimationController transitionInAnimation;
  late final AnimationController transitionOutAnimation;

  List<SingleChildWidget> get provided => [
    BlocProvider.value(value: learnPageBloc),
    BlocProvider.value(value: indirectStepsCubit),
    Provider.value(value: MessageAnimationController(messageAnimation)),
    Provider.value(value: TransitionInAnimationController(transitionInAnimation)),
    Provider.value(value: TransitionOutAnimationController(transitionOutAnimation)),
  ];

  List<BlocListener> get listeners => [
    BlocListener<LearnPageBloc, LearnPageState>(
      bloc: learnPageBloc,
      listener: (context, state) {
        switch (state) {
          /// If there is an error, we show a snackbar.
          case LoadedLearnPageState(:var error?):
            context.showBasicSnackbar(error.toString());

          /// This is the state when the user has answered a question.
          case LoadedLearnPageState(status: LearnPageStatus.correct):
          case LoadedLearnPageState(status: LearnPageStatus.incorrect):
            messageAnimation.forward(from: 0.0);

          /// When we are [LearnPageStatus.movingAway], then we
          ///   reverse the animation.
          case LoadedLearnPageState(status: LearnPageStatus.movingAway):
            messageAnimation.reverse(from: 1.0);

          /// If the chapter is finished, then we let the bloc know
          ///   that the user has completed the chapter.
          /// This will trigger the UserDataBloc to update the stored local data.
          ///   This will also asynchronously update the server data.
          case LoadedLearnPageState(status: LearnPageStatus.finished, :var startDateTime):
            var duration = DateTime.now().difference(startDateTime);
            var correctAnswers = state.questions.length - state.mistakes;
            var totalAnswers = state.questions.length;

            context.read<UserDataBloc>().add(
              ChapterCompletedUserDataEvent(
                chapterType: ChapterType.learn,
                lessonId: learnPageBloc.loadedState.lesson.id,
                chapterIndex: learnPageBloc.loadedState.chapterIndex,
                correctAnswers: correctAnswers,
                totalAnswers: totalAnswers,
                duration: duration,
              ),
            );

          case LoadedLearnPageState(status: LearnPageStatus.leaving):
            if (context.canPop()) {
              context.pop();
            } else {
              if (kDebugMode) {
                print("Going to lesson: ${learnPageBloc.loadedState.lesson.id}.");
              }
              context.goNamed(
                AppRoutes.lesson,
                pathParameters: {"lessonId": learnPageBloc.loadedState.lesson.id},
              );
            }
            return;

          /// Ignore the other statuses.
          case _:
            return;
        }
      },
    ),
    BlocListener<LearnPageBloc, LearnPageState>(
      bloc: learnPageBloc,
      listener: (context, state) {
        if (state is! LoadedLearnPageState) return;

        /// Animation engine.
        if (state.status == LearnPageStatus.movingIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!context.mounted) return;

            transitionOutAnimation.reset();
            transitionInAnimation.reset();
            try {
              await transitionInAnimation.forward(from: 0.0);
            } finally {
              transitionInAnimation.value = 1.0;
            }
            if (!context.mounted) return;
            if (learnPageBloc.isClosed) return;

            /// This is a bit of a hack, but we need to set the animation to be 1.0
            ///   so that the animation is completed whether or not the animation completes.
            transitionInAnimation.value = 1.0;
            learnPageBloc.add(const LearnPageMovingInComplete());
          });
        } else if (state.status == LearnPageStatus.movingAway) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!context.mounted) return;

            /// Just instantly hide the message.

            messageAnimation.reset();
            // transitionInAnimation.reset();
            transitionOutAnimation.reset();
            await transitionOutAnimation.forward(from: 0.0);
            if (!context.mounted) return;
            if (learnPageBloc.isClosed) return;

            learnPageBloc.add(const LearnPageMovingAwayComplete());
          });
        }
      },
      listenWhen: (p, c) {
        return (p is BlankLearnPageState && c is LoadedLearnPageState) ||
            (p is LoadedLearnPageState && c is LoadedLearnPageState && p.status != c.status);
      },
    ),
  ];

  static void initiateLeave(LearnPageBloc bloc, BuildContext context) async {
    var lesson = bloc.loadedState.lesson;
    var questionIndex = bloc.loadedState.questionIndex;
    var shouldPop = false;
    if (questionIndex == 0) {
      shouldPop = true;
    } else {
      shouldPop = await context.showConfirmationDialog(
        title: "Quit?",
        message: "Are you sure you want to quit? Your progress will **NOT** be saved.",
        cancelButtonText: "Return",
        confirmButtonText: "Quit",
        cancelButtonColor: bloc.loadedState.lesson.color,
        confirmButtonColor: const Color(0xFFC63A3A),
      );
    }

    if (context.mounted && shouldPop) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.pushReplacementNamed(AppRoutes.lesson, pathParameters: {"id": lesson.id});
      }
    }
  }

  @override
  void initState() {
    super.initState();

    var helper = context.read<LessonsHelper>();
    learnPageBloc = LearnPageBloc(lessonsHelper: helper);

    indirectStepsCubit = IndirectStepsCubit();

    messageAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    transitionInAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    transitionOutAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    learnPageBloc.add(
      LearnPageWidgetChanged(
        lesson: context.read<LessonsHelper>().getLesson(widget.lessonId),
        chapterIndex: widget.chapterIndex,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LearnPage oldWidget) {
    if (widget.lessonId != oldWidget.lessonId || widget.chapterIndex != oldWidget.chapterIndex) {
      learnPageBloc.add(
        LearnPageWidgetChanged(
          lesson: context.read<LessonsHelper>().getLesson(widget.lessonId),
          chapterIndex: widget.chapterIndex,
        ),
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    learnPageBloc.close();
    indirectStepsCubit.close();
    messageAnimation.dispose();
    transitionInAnimation.dispose();
    transitionOutAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: listeners,
      child: MultiProvider(
        providers: provided,
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            initiateLeave(learnPageBloc, context);
          },
          child: NotificationListener(
            onNotification: (UserQuitNotification notification) {
              initiateLeave(learnPageBloc, context);
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0.0,
                scrolledUnderElevation: 0.0,
                elevation: 0.0,
                forceMaterialTransparency: true,
              ),
              body: BlocBuilder(
                bloc: learnPageBloc,
                buildWhen: (previous, current) {
                  assert(
                    !(previous is LoadedLearnPageState && current is LoadingLearnPageState),
                    "We should never get in a state where we are loading a page "
                    "while we were already in a loaded state.",
                  );
                  if (previous.runtimeType != current.runtimeType) {
                    return true;
                  }

                  try {
                    var p = previous as LoadedLearnPageState;
                    var c = current as LoadedLearnPageState;

                    if (p.questions[p.questionIndex] != c.questions[c.questionIndex]) {
                      return true;
                    }

                    return false;
                  } on Object {
                    return false;
                  }
                },
                builder: (context, state) {
                  if (state is! LoadedLearnPageState) {
                    return const Material(child: Center(child: CircularProgressIndicator()));
                  }

                  return switch (state.questions[state.questionIndex]) {
                    IndirectStepsLearnQuestion question => IndirectStepsLearnPage(
                      question: question,
                      child: const LearnPageView(),
                    ),
                    _ => const LearnPageView(),
                  };
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlyingUnit extends StatelessWidget {
  final (Unit, Offset, Offset) animation;

  const FlyingUnit({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    var controller = context.select((IndirectStepsCubit c) => c.activeState.animationController);
    var (unit, from, to) = animation;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        var offset =
            Tween(begin: from, end: to)
                .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)) //
                .value;

        return Positioned(left: offset.dx, top: offset.dy, child: child!);
      },
      child: ChoiceUnitTile(unit: unit),
    );
  }
}

class IndirectStepsLearnPage extends HookWidget {
  const IndirectStepsLearnPage({super.key, required this.child, required this.question});

  final Widget child;
  final IndirectStepsLearnQuestion question;

  @override
  Widget build(BuildContext context) {
    var controller = useAnimationController(duration: 200.ms);

    /// We want to set up the question whenever the question changes.
    useEffect(() {
      context.read<IndirectStepsCubit>().setupQuestion(controller, question);
    }, [question]);

    useBlocListener(
      context.read<IndirectStepsCubit>(),
      (state) {
        if (state is! ActiveIndirectStepsState) {
          return;
        }

        late var bloc = context.read<LearnPageBloc>();
        var allUnits = state.answers.map((u) => u?.$2).whereType<Unit>().toList();
        if (allUnits.length == state.question.answer.length) {
          bloc.add(LearnPageAnswerUpdated.indirectSteps(answer: allUnits));
        } else {
          bloc.add(const LearnPageAnswerUpdated.indirectSteps(answer: null));
        }
      },
      listenWhen: (p, c) {
        return p is ActiveIndirectStepsState &&
            c is ActiveIndirectStepsState &&
            p.answers.whereType<Object>().length != c.answers.whereType<Object>().length;
      },
    );

    var state = useBlocBuilder(
      context.read<IndirectStepsCubit>(),
      buildWhen: (p, c) {
        if (p is! ActiveIndirectStepsState || c is! ActiveIndirectStepsState) {
          return false;
        }

        return (p.animation != c.animation) || (p.parentKey != c.parentKey);
      },
    );

    var key = (state as ActiveIndirectStepsState).parentKey;
    var animation = state.animation;

    return Stack(
      key: key,
      children: [
        Positioned.fill(child: child),

        /// This is so cursed.
        if (animation case var animation?) FlyingUnit(animation: animation),
      ],
    );
  }
}

class LearnPageView extends HookWidget {
  const LearnPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var progressBarKey = useMemoized(() => GlobalKey());
    var status = context.select((LearnPageBloc b) => b.loadedState.status);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        forceMaterialTransparency: true,
      ),
      body: Stack(
        children: [
          if (status == LearnPageStatus.finished)
            Positioned.fill(child: CompletedLearnBody(progressBarKey: progressBarKey))
          else ...[
            Positioned.fill(child: LearnBody(progressBarKey: progressBarKey)),

            const Positioned.fill(child: LearnCongratulatoryBarrier()),
            const Positioned(bottom: 0, left: 0, right: 0, child: CongratulatoryMessage()),
            const Positioned(bottom: 0, left: 0, right: 0, child: LearnContinueButton()),
          ],
        ],
      ),
    );
  }
}
