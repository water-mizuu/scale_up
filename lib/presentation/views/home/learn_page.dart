import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/check_button.dart";
import "package:scale_up/presentation/views/home/learn_page/choices.dart";
import "package:scale_up/presentation/views/home/learn_page/instructions.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_progress_bar.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LearnPage extends StatefulWidget {
  const LearnPage({required this.lessonId, required this.chapterIndex, super.key});

  final String lessonId;
  final int chapterIndex;

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class MessageAnimationController {
  const MessageAnimationController(this.controller);
  final AnimationController controller;
}

class TransitionInAnimationController {
  const TransitionInAnimationController(this.controller);
  final AnimationController controller;
}

class TransitionOutAnimationController {
  const TransitionOutAnimationController(this.controller);
  final AnimationController controller;
}

class _LearnPageState extends State<LearnPage> with TickerProviderStateMixin {
  late final AnimationController messageAnimation;
  late final AnimationController transitionInAnimation;
  late final AnimationController transitionOutAnimation;
  late final GlobalKey progressBarKey;
  late final LearnPageBloc bloc;

  @override
  void initState() {
    super.initState();

    messageAnimation = AnimationController(vsync: this, duration: 500.milliseconds);
    transitionInAnimation = AnimationController(vsync: this, duration: 500.milliseconds);
    transitionOutAnimation = AnimationController(vsync: this, duration: 500.milliseconds);

    progressBarKey = GlobalKey();
    bloc = LearnPageBloc(
      lessonsHelper: context.read<LessonsHelper>(),
      lessonFuture: context.read<LessonsHelper>().getLesson(widget.lessonId),
      chapterIndex: widget.chapterIndex,
    );
  }

  @override
  void didUpdateWidget(covariant LearnPage oldWidget) {
    if (oldWidget.lessonId != widget.lessonId || oldWidget.chapterIndex != widget.chapterIndex) {
      bloc.add(
        LearnPageWidgetChangedEvent(
          lessonFuture: context.read<LessonsHelper>().getLesson(widget.lessonId),
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
        child: BlocListener<LearnPageBloc, LearnPageState>(
          bloc: bloc,
          listenWhen: (previous, current) {
            return previous.status == LearnPageStatus.evaluating ||
                current.status == LearnPageStatus.movingAway;
          },
          listener: (context, state) {
            if (state.status case LearnPageStatus.correct || LearnPageStatus.incorrect) {
              messageAnimation.forward(from: 0.0);
            } else if (state.status case LearnPageStatus.movingAway) {
              messageAnimation.reverse(from: 1.0);
            }
          },
          child: BlocListener<LearnPageBloc, LearnPageState>(
            bloc: bloc,
            listenWhen: (p, c) => p.status != c.status,
            listener: (context, state) async {
              /// Animation engine.
              if (state.status == LearnPageStatus.movingIn) {
                transitionOutAnimation.reset();
                await transitionInAnimation.forward(from: 0.0);
                if (bloc.isClosed) return;

                bloc.add(LearnPageToTransitionCompleteEvent());
              } else if (state.status == LearnPageStatus.movingAway) {
                await transitionOutAnimation.forward(from: 0.0);

                if (bloc.isClosed) return;
                bloc.add(LearnPageFromTransitionCompleteEvent());
              }
            },
            child: BlocBuilder<LearnPageBloc, LearnPageState>(
              builder: (context, state) {
                if (state is! LoadedLearnPageState) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Stack(
                  children: [
                    if (state.status == LearnPageStatus.finishedWithAllQuestions)
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LearnProgressBar(progressBarKey: progressBarKey),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Congratulations! You have completed all questions.",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else ...[
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                spacing: 18.0,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  LearnProgressBar(progressBarKey: progressBarKey),
                                  Instructions(),
                                ],
                              ),
                              const Column(
                                spacing: 18.0,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [Choices(), CheckButton()],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(bottom: 0, left: 0, right: 0, child: CongratulatoryMessage()),
                      Positioned(bottom: 0, left: 0, right: 0, child: ContinueMessage()),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ContinueMessage extends StatelessWidget {
  const ContinueMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnPageBloc, LearnPageState>(
      buildWhen: (p, c) => (p as LoadedLearnPageState).status == LearnPageStatus.evaluating,
      builder: (context, state) {
        if (state.status case LearnPageStatus.correct || LearnPageStatus.incorrect) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0) - EdgeInsets.only(top: 16.0),
                child: CheckButton(),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class CongratulatoryMessage extends StatelessWidget {
  const CongratulatoryMessage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.read<LearnPageBloc>().state;
    var controller = context.read<MessageAnimationController>().controller;

    return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.status == LearnPageStatus.correct) ...[
                      Styles.title("Correct!", color: Colors.green),
                      Styles.subtitle(
                        "You got it right!",
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ] else if (state.status == LearnPageStatus.incorrect) ...[
                      Styles.subtitle("Oops!", color: Theme.of(context).colorScheme.error),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "The answer was ",
                              style: Styles.subtitle.copyWith(
                                color: Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "${(state as LoadedLearnPageState).correctAnswer}",
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
        )
        .animate(controller: controller, autoPlay: false)
        .slideY(begin: 2.0, end: 0.0, curve: Curves.easeIn);
  }
}
