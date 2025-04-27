import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";
import "package:scale_up/presentation/bloc/IndirectSteps/indirect_steps_cubit.dart";
import "package:scale_up/presentation/bloc/IndirectSteps/indirect_steps_state.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/learn_page/completed_learn_body.dart";
import "package:scale_up/presentation/views/home/learn_page/congratulatory_message.dart";
import "package:scale_up/presentation/views/home/learn_page/continue_message.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_body.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/snackbar_util.dart";

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
  late final AnimationController messageAnimation;
  late final AnimationController transitionInAnimation;
  late final AnimationController transitionOutAnimation;
  late final LearnPageBloc bloc;

  @override
  void initState() {
    super.initState();

    messageAnimation = AnimationController(vsync: this, duration: 500.ms);
    transitionInAnimation = AnimationController(vsync: this, duration: 500.ms);
    transitionOutAnimation = AnimationController(vsync: this, duration: 500.ms);

    bloc = LearnPageBloc(
      lessonsHelper: context.read<LessonsHelper>(),
      lesson: context.read<LessonsHelper>().getLesson(widget.lessonId),
      chapterIndex: widget.chapterIndex,
    );
  }

  @override
  void didUpdateWidget(covariant LearnPage oldWidget) {
    if (oldWidget.lessonId != widget.lessonId || oldWidget.chapterIndex != widget.chapterIndex) {
      bloc.add(
        LearnPageWidgetChanged(
          lesson: context.read<LessonsHelper>().getLesson(widget.lessonId)!,
          chapterIndex: widget.chapterIndex,
        ),
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    messageAnimation.dispose();
    bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiProvider(
        providers: [
          BlocProvider.value(value: bloc),
          InheritedProvider.value(value: MessageAnimationController(messageAnimation)),
          InheritedProvider.value(value: TransitionInAnimationController(transitionInAnimation)),
          InheritedProvider.value(
            value: TransitionOutAnimationController(transitionOutAnimation),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<LearnPageBloc, LearnPageState>(
              bloc: bloc,
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
                  case LoadedLearnPageState(status: LearnPageStatus.finished):
                    context.read<UserDataBloc>().add(
                      LearnChapterCompletedUserDataEvent(
                        lessonId: bloc.loadedState.lesson.id,
                        chapterIndex: bloc.loadedState.chapterIndex,
                      ),
                    );

                  case LoadedLearnPageState(status: LearnPageStatus.leaving):
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.goNamed(
                        AppRoutes.lesson,
                        pathParameters: {"lessonId": bloc.loadedState.lesson.id},
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
              bloc: bloc,
              listenWhen: (p, c) => p.status != c.status,
              listener: (context, state) async {
                /// Animation engine.
                if (state.status == LearnPageStatus.movingIn) {
                  transitionOutAnimation.reset();
                  await transitionInAnimation.forward(from: 0.0);
                  if (bloc.isClosed) return;

                  bloc.add(LearnPageMovingInComplete());
                } else if (state.status == LearnPageStatus.movingAway) {
                  /// Just instantly hide the message.
                  messageAnimation.reset();
                  await transitionOutAnimation.forward(from: 0.0);
                  if (bloc.isClosed) return;

                  bloc.add(LearnPageMovingAwayComplete());
                }
              },
            ),
          ],
          child: BlocBuilder<LearnPageBloc, LearnPageState>(
            bloc: bloc,
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

              var child = InheritedProvider.value(
                value: bloc.loadedState.lesson.hslColor,
                child: LearnPageView(),
              );
              var question = state.questions[state.questionIndex];
              if (question is IndirectStepsLearnQuestion) {
                return MultiProvider(
                  providers: [
                    BlocProvider(
                      key: ValueKey(question),
                      create: (_) => IndirectStepsCubit(this, question),
                    ),
                  ],
                  builder: (context, _) {
                    var key = context.read<IndirectStepsCubit>().state.parentKey;
                    var animation = context.select((IndirectStepsCubit c) => c.state.animation);

                    return BlocListener<IndirectStepsCubit, IndirectStepsState>(
                      listenWhen:
                          (p, c) =>
                              p.answers.whereType<Object>().length !=
                              c.answers.whereType<Object>().length,
                      listener: (context, state) {
                        var allUnits =
                            state
                                .answers //
                                .map((u) => u?.$2)
                                .whereType<Unit>()
                                .toList();

                        if (allUnits.length == question.answer.length) {
                          bloc.add(LearnPageAnswerUpdated.indirectSteps(answer: allUnits));
                        } else {
                          bloc.add(LearnPageAnswerUpdated.indirectSteps(answer: null));
                        }
                      },
                      child: Stack(
                        key: key,
                        children: [
                          Positioned.fill(child: child),

                          /// This is so cursed.
                          if (animation case var animation?) FlyingUnit(animation: animation),
                        ],
                      ),
                    );
                  },
                );
              }

              return child;
            },
          ),
        ),
      ),
    );
  }
}

class FlyingUnit extends StatelessWidget {
  const FlyingUnit({super.key, required this.animation});

  final (Unit, Offset, Offset) animation;

  @override
  Widget build(BuildContext context) {
    var controller = context.read<IndirectStepsCubit>().state.animationController;
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

class LearnPageView extends StatefulWidget {
  const LearnPageView({super.key});

  @override
  State<LearnPageView> createState() => _LearnPageViewState();
}

class _LearnPageViewState extends State<LearnPageView> {
  late final GlobalKey progressBarKey;

  @override
  void initState() {
    super.initState();

    progressBarKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    var status = context.select((LearnPageBloc b) => b.state.status);

    return Stack(
      children: [
        if (status == LearnPageStatus.finished)
          Positioned.fill(child: CompletedLearnBody(progressBarKey: progressBarKey))
        else ...[
          Positioned.fill(child: LearnBody(progressBarKey: progressBarKey)),

          Positioned(bottom: 0, left: 0, right: 0, child: CongratulatoryMessage()),
          Positioned(bottom: 0, left: 0, right: 0, child: ContinueMessage()),
        ],
      ],
    );
  }
}
