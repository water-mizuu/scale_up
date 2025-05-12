import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_event.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_state.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/notifications/user_quit_notification.dart";
import "package:scale_up/presentation/views/home/practice_page/"
    "completed_practice_body.dart";
import "package:scale_up/presentation/views/home/practice_page/"
    "practice_body.dart";
import "package:scale_up/presentation/views/home/practice_page/"
    "practice_congratulatory_barrier.dart";
import "package:scale_up/presentation/views/home/practice_page/"
    "practice_congratulatory_message.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_continue_button.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/extensions/snackbar_extension.dart";

/// We assume that each instance of the ChapterPage is a new set of questions.
class PracticePage extends StatefulWidget {
  const PracticePage({required this.lessonId, required this.chapterIndex, super.key});

  final String lessonId;
  final int chapterIndex;

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> with TickerProviderStateMixin {
  late final PracticePageBloc bloc;
  late final AnimationController messageAnimation;
  late final AnimationController transitionInAnimation;
  late final AnimationController transitionOutAnimation;

  @override
  void initState() {
    super.initState();

    var lessonsHelper = context.read<LessonsHelper>();

    messageAnimation = AnimationController(vsync: this, duration: 500.milliseconds);
    transitionInAnimation = AnimationController(vsync: this, duration: 500.milliseconds);
    transitionOutAnimation = AnimationController(vsync: this, duration: 500.milliseconds);
    bloc = PracticePageBloc(
      chapterIndex: widget.chapterIndex,
      lessonsHelper: lessonsHelper,
      lesson: lessonsHelper.getLesson(widget.lessonId),
    );
  }

  void _initiateLeave(BuildContext context) async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        forceMaterialTransparency: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) async {
          if (didPop) return;
          _initiateLeave(context);
        },
        child: NotificationListener<UserQuitNotification>(
          onNotification: (notification) {
            _initiateLeave(context);
            return true;
          },
          child: MultiProvider(
            providers: [
              BlocProvider.value(value: bloc),
              Provider.value(value: bloc.state.lesson!.hslColor),
              Provider.value(value: MessageAnimationController(messageAnimation)),
              Provider.value(value: TransitionInAnimationController(transitionInAnimation)),
              Provider.value(value: TransitionOutAnimationController(transitionOutAnimation)),
            ],
            child: MultiBlocListener(
              listeners: [
                BlocListener<PracticePageBloc, PracticePageState>(
                  bloc: bloc,
                  listener: (context, state) async {
                    switch (state) {
                      /// If there is an error, we show a snackbar.
                      case LoadedPracticePageState(:var error?):
                        await context.showBasicSnackbar(error.toString());

                      /// This is the state when the user has answered a question.
                      case LoadedPracticePageState(status: PracticePageStatus.correct):
                      case LoadedPracticePageState(status: PracticePageStatus.incorrect):
                        messageAnimation.forward(from: 0.0);

                      /// When we are [PracticePageStatus.movingAway], then we
                      ///   reverse the animation.
                      case LoadedPracticePageState(status: PracticePageStatus.movingAway):
                        messageAnimation.reverse(from: 1.0);

                      /// If the chapter is finished, then we let the bloc know
                      ///   that the user has completed the chapter.
                      /// This will trigger the UserDataBloc to update the stored local data.
                      ///   This will also asynchronously update the server data.
                      case LoadedPracticePageState(
                        status: PracticePageStatus.finished,
                        :var startDateTime,
                      ):
                        var duration = DateTime.now().difference(startDateTime);
                        var correctAnswers = state.questions.length - state.mistakes;
                        var totalAnswers = state.questions.length;

                        context.read<UserDataBloc>().add(
                          ChapterCompletedUserDataEvent(
                            chapterType: ChapterType.practice,
                            lessonId: bloc.loadedState.lesson.id,
                            chapterIndex: bloc.loadedState.chapterIndex,
                            correctAnswers: correctAnswers,
                            totalAnswers: totalAnswers,
                            duration: duration,
                          ),
                        );
                      case LoadedPracticePageState(status: PracticePageStatus.leaving):
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
                BlocListener<PracticePageBloc, PracticePageState>(
                  bloc: bloc,
                  listenWhen: (p, c) => p.status != c.status,
                  listener: (context, state) async {
                    /// Animation engine.
                    ///   Is there a way to do this in the BLoC itself?
                    if (state.status == PracticePageStatus.movingIn) {
                      transitionOutAnimation.reset();
                      await transitionInAnimation.forward(from: 0.0);
                      if (bloc.isClosed) return;

                      bloc.add(const PracticePageToTransitionComplete());
                    } else if (state.status == PracticePageStatus.movingAway) {
                      /// Just instantly hide the message.
                      messageAnimation.reset();
                      await transitionOutAnimation.forward(from: 0.0);

                      if (bloc.isClosed) return;
                      bloc.add(const PracticePageFromTransitionComplete());
                    }
                  },
                ),
              ],
              child: BlocBuilder<PracticePageBloc, PracticePageState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is! LoadedPracticePageState) {
                    return const Material(child: Center(child: CircularProgressIndicator()));
                  }

                  return const PracticePageView();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PracticePageView extends HookWidget {
  const PracticePageView({super.key});

  @override
  Widget build(BuildContext context) {
    var progressBarKey = useMemoized(() => GlobalKey());
    var isFinished = context.select((PracticePageBloc b) {
      return b.state.status == PracticePageStatus.finished;
    });

    return Stack(
      children: [
        if (isFinished)
          Positioned.fill(child: CompletedPracticeBody(progressBarKey: progressBarKey))
        else ...[
          Positioned.fill(child: PracticeBody(progressBarKey: progressBarKey)),

          const Positioned.fill(child: PracticeCongratulatoryBarrier()),
          const Positioned(bottom: 0, left: 0, right: 0, child: PracticeCongratulatoryMessage()),
          const Positioned(bottom: 0, left: 0, right: 0, child: PracticeContinueButton()),
        ],
      ],
    );
  }
}
