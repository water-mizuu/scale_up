import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/hooks/use_bloc_builder.dart";
import "package:scale_up/hooks/use_bloc_listener.dart";
import "package:scale_up/hooks/use_new_bloc.dart";
import "package:scale_up/hooks/use_provider_hooks.dart";
import "package:scale_up/presentation/bloc/indirect_steps/indirect_steps_cubit.dart";
import "package:scale_up/presentation/bloc/indirect_steps/indirect_steps_state.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/learn_page/completed_learn_body.dart";
import "package:scale_up/presentation/views/home/learn_page/congratulatory_message.dart";
import "package:scale_up/presentation/views/home/learn_page/continue_message.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_body.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices/choice_unit_tile.dart";
import "package:scale_up/presentation/views/home/notifications/user_quit_notification.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/extensions/snackbar_extension.dart";

class LearnPage extends HookWidget {
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
  Widget build(BuildContext context) {
    var messageAnimation = useAnimationController(duration: 500.ms);
    var transitionInAnimation = useAnimationController(duration: 500.ms);
    var transitionOutAnimation = useAnimationController(duration: 500.ms);

    /// Create the bloc.
    var helper = useRead<LessonsHelper>();
    var learnPageBloc = useCreateNewBloc(() => LearnPageBloc(lessonsHelper: helper));
    var indirectStepsCubit = useCreateNewBloc(() => IndirectStepsCubit());

    /// Whenever the lessonId or chapterIndex changes, we want to
    ///   update the bloc with the new lesson and chapter index.
    useEffect(() {
      learnPageBloc.add(
        LearnPageWidgetChanged(
          lesson: context.read<LessonsHelper>().getLesson(lessonId), //
          chapterIndex: chapterIndex,
        ),
      );
    }, [lessonId, chapterIndex]);

    /// LISTENERS.
    useBlocListener(learnPageBloc, (state) {
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
    });

    useBlocListener(
      learnPageBloc,
      (state) async {
        if (state is! LoadedLearnPageState) return;

        /// Animation engine.
        if (state.status == LearnPageStatus.movingIn) {
          transitionOutAnimation.reset();
          await transitionInAnimation.forward(from: 0.0);
          if (learnPageBloc.isClosed) return;

          learnPageBloc.add(const LearnPageMovingInComplete());
        } else if (state.status == LearnPageStatus.movingAway) {
          /// Just instantly hide the message.
          messageAnimation.reset();
          await transitionOutAnimation.forward(from: 0.0);
          if (learnPageBloc.isClosed) return;

          learnPageBloc.add(const LearnPageMovingAwayComplete());
        }
      },
      listenWhen: (p, c) {
        return (p is BlankLearnPageState && c is LoadedLearnPageState) ||
            (p is LoadedLearnPageState && c is LoadedLearnPageState && p.status != c.status);
      },
    );

    return Material(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) async {
          if (didPop) return;
          initiateLeave(learnPageBloc, context);
        },
        child: NotificationListener<UserQuitNotification>(
          onNotification: (notification) {
            initiateLeave(learnPageBloc, context);
            return true;
          },
          child: MultiProvider(
            providers: [
              BlocProvider.value(value: indirectStepsCubit),
              BlocProvider.value(value: learnPageBloc),
              Provider.value(value: MessageAnimationController(messageAnimation)),
              Provider.value(value: TransitionInAnimationController(transitionInAnimation)),
              Provider.value(value: TransitionOutAnimationController(transitionOutAnimation)),
            ],
            child: BlocBuilder<LearnPageBloc, LearnPageState>(
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

                switch (state.questions[state.questionIndex]) {
                  case PlainLearnQuestion _:
                  case DirectFormulaLearnQuestion _:
                  case ImportantNumbersLearnQuestion _:
                    return const LearnPageView();
                  case IndirectStepsLearnQuestion question:
                    return IndirectStepsLearnPage(
                      question: question,
                      child: const LearnPageView(),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

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
  final IndirectStepsLearnQuestion question;

  final Widget child;
  const IndirectStepsLearnPage({super.key, required this.question, required this.child});

  @override
  Widget build(BuildContext context) {
    var controller = useAnimationController(duration: 200.ms);
    var indirectStepsCubit = useRead<IndirectStepsCubit>();
    var learnPageBloc = useRead<LearnPageBloc>();

    /// We want to set up the question whenever the question changes.
    useEffect(() {
      indirectStepsCubit.setupQuestion(controller, question);
    }, [question]);

    var state = useBlocBuilder(
      indirectStepsCubit,
      buildWhen: (p, c) {
        if (p is! ActiveIndirectStepsState || c is! ActiveIndirectStepsState) {
          return false;
        }

        return (p.animation != c.animation) || (p.parentKey != c.parentKey);
      },
    );

    useBlocListener(
      indirectStepsCubit,
      (state) {
        if (state is! ActiveIndirectStepsState) {
          return;
        }

        var allUnits = state.answers.map((u) => u?.$2).whereType<Unit>().toList();
        if (allUnits.length == question.answer.length) {
          learnPageBloc.add(LearnPageAnswerUpdated.indirectSteps(answer: allUnits));
        } else {
          learnPageBloc.add(const LearnPageAnswerUpdated.indirectSteps(answer: null));
        }
      },
      listenWhen: (p, c) {
        return p is ActiveIndirectStepsState &&
            c is ActiveIndirectStepsState &&
            p.answers.whereType<Object>().length != c.answers.whereType<Object>().length;
      },
      keys: [question],
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
    var progressBarKey = useRef(GlobalKey()).value;
    var status = useSelect((LearnPageBloc b) => (b.state as LoadedLearnPageState).status);

    return Stack(
      children: [
        if (status == LearnPageStatus.finished)
          Positioned.fill(child: CompletedLearnBody(progressBarKey: progressBarKey))
        else ...[
          Positioned.fill(child: LearnBody(progressBarKey: progressBarKey)),

          const Positioned(bottom: 0, left: 0, right: 0, child: CongratulatoryMessage()),
          const Positioned(bottom: 0, left: 0, right: 0, child: ContinueMessage()),
        ],
      ],
    );
  }
}
