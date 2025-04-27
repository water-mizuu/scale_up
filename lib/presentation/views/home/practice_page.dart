import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/practice_page/completed_practice_body.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_body.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_page_check_button.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/snackbar_util.dart";

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

  @override
  Widget build(BuildContext context) {
    return Material(
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
                  case LoadedPracticePageState(status: PracticePageStatus.finished):
                    context.read<UserDataBloc>().add(
                      PracticeChapterCompletedUserDataEvent(
                        lessonId: bloc.loadedState.lesson.id,
                        chapterIndex: bloc.state.chapterIndex,
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

                  bloc.add(PracticePageToTransitionComplete());
                } else if (state.status == PracticePageStatus.movingAway) {
                  /// Just instantly hide the message.
                  messageAnimation.reset();
                  await transitionOutAnimation.forward(from: 0.0);

                  if (bloc.isClosed) return;
                  bloc.add(PracticePageFromTransitionComplete());
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

              return PracticePageView();
            },
          ),
        ),
      ),
    );
  }
}

class PracticePageView extends StatefulWidget {
  const PracticePageView({super.key});

  @override
  State<PracticePageView> createState() => _PracticePageViewState();
}

class _PracticePageViewState extends State<PracticePageView> {
  late final GlobalKey progressBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var state = context.select((PracticePageBloc bloc) => bloc.state);

    return Stack(
      children: [
        if (state.status == PracticePageStatus.finished)
          Positioned.fill(child: CompletedPracticeBody(progressBarKey: progressBarKey))
        else ...[
          Positioned.fill(child: PracticeBody(progressBarKey: progressBarKey)),

          Positioned(bottom: 0, left: 0, right: 0, child: CongratulatoryMessage()),
          Positioned(bottom: 0, left: 0, right: 0, child: ContinueMessage()),
        ],
      ],
    );
  }
}

/// This widget is used to show the continue button.
class ContinueMessage extends StatelessWidget {
  const ContinueMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticePageBloc, PracticePageState>(
      buildWhen: (p, c) => (p as LoadedPracticePageState).status == PracticePageStatus.evaluating,
      builder: (context, state) {
        if (state.status case PracticePageStatus.correct || PracticePageStatus.incorrect) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0) - EdgeInsets.only(top: 16.0),
                child: PracticePageCheckButton(),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

/// This widget is used to show the backdrop of the continue button.
class CongratulatoryMessage extends StatelessWidget {
  const CongratulatoryMessage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.read<PracticePageBloc>().loadedState;
    var controller = context.read<MessageAnimationController>().controller;

    var widget = DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [defaultBoxShadow.first.copyWith(offset: Offset(0, -2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state.status == PracticePageStatus.correct) ...[
                  Styles.title("Correct!", color: Colors.green),
                  Styles.subtitle(
                    "You got it right!",
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ] else if (state.status == PracticePageStatus.incorrect) ...[
                  Styles.title("Oops!", color: Colors.red),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "The answer was ",
                          style: Styles.subtitle.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "${state.correctAnswer}",
                          style: Styles.subtitle.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0) - EdgeInsets.only(top: 16.0),
            child: TickerMode(
              enabled: false,
              child: FilledButton(
                onPressed: null,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Check",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return widget
        .animate(controller: controller, autoPlay: false)
        .slideY(begin: 1.0, end: 0.0, curve: Curves.linearToEaseOut);
  }
}
