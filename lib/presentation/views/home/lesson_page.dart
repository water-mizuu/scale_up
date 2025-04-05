import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/chapter.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/presentation/views/widgets/unit_tile.dart";
import "package:scale_up/utils/snackbar_util.dart";
import "package:scroll_animator/scroll_animator.dart";

class LessonPage extends StatefulWidget {
  const LessonPage({required this.id, super.key});

  final String id;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late final Future<Lesson?> lessonFuture;

  @override
  void initState() {
    super.initState();

    lessonFuture = context.read<LessonsHelper>().getLesson(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: lessonFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          context.showBasicSnackbar(snapshot.error.toString());
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        assert(snapshot.hasData);
        switch (snapshot.data) {
          case Lesson lesson:
            return MultiProvider(
              providers: [BlocProvider(create: (_) => LessonPageBloc(lesson))],
              child: LessonPageView(lesson: lesson),
            );
          case null:
            return BlankLessonPage(id: widget.id);
        }
      },
    );
  }
}

class BlankLessonPage extends StatelessWidget {
  const BlankLessonPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, scrolledUnderElevation: 0.0, title: Text("Lesson page")),
      body: Center(child: Text("Lesson not found '$id'")),
    );
  }
}

class LessonPageView extends StatelessWidget {
  const LessonPageView({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: lesson.color,
        foregroundColor: lesson.foregroundColor,
      ),
      body: InheritedProvider.value(
        value: lesson,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [LessonDescription(), Expanded(child: LessonInformation())],
        ),
      ),
    );
  }
}

class LessonDescription extends StatelessWidget {
  const LessonDescription({super.key});

  @override
  Widget build(BuildContext context) {
    var lesson = context.read<Lesson>();

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: lesson.color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Styles.title.copyWith(color: lesson.foregroundColor)(lesson.name),
          Styles.body.copyWith(color: lesson.foregroundColor)(lesson.description),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}

class LessonInformation extends StatelessWidget {
  const LessonInformation({super.key});

  @override
  Widget build(BuildContext context) {
    // I don't want to create a StatefulWidget just to use this controller.
    //   Thankfully, providers automatically dispose of the values.
    return InheritedProvider(
      create: (_) => AnimatedScrollController(animationFactory: const ChromiumEaseInOut()),
      dispose: (_, v) => v.dispose(),
      builder:
          (context, child) => SingleChildScrollView(
            controller: context.read<AnimatedScrollController>(),
            child: child,
          ),
      child: LessonInformationView(),
    );
  }
}

class LessonInformationView extends StatelessWidget {
  const LessonInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [LessonProgression(), LessonUnits(), LessonChapters()],
      ),
    );
  }
}

class LessonChapters extends StatelessWidget {
  const LessonChapters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Lesson Content"),
        Column(
          spacing: 4.0,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var (index, chapter) in context.read<Lesson>().chapters.indexed)
              ChapterTile(index: index, chapter: chapter),
          ],
        ),
      ],
    );
  }
}

class ChapterTile extends StatelessWidget {
  const ChapterTile({super.key, required this.index, required this.chapter});

  final int index;
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    var lessonId = context.read<Lesson>().id;
    var key = "$lessonId:$index";
    var isComplete = context.select<UserDataBloc, bool>(
      (bloc) => bloc.state.finishedChapters.contains(key),
    );

    return Material(
      elevation: 12.0,
      borderRadius: BorderRadius.circular(25.0),
      shadowColor: Colors.black.withValues(alpha: 0.3),
      child: ListTile(
        leading: ChapterIndex(index: index, isCompleted: isComplete),
        title: Styles.body(chapter.name, fontSize: 14),
        subtitle: Styles.body("${chapter.questionCount} questions", color: Colors.grey),
        onTap:
            isComplete
                ? null
                : () {
                  context.pushNamed(
                    AppRoutes.chapter,
                    pathParameters: {"id": lessonId, "chapterIndex": "$index"},
                  );
                },
        tileColor: Colors.white,
      ),
    );
  }
}

class ChapterIndex extends StatelessWidget {
  const ChapterIndex({super.key, required this.index, required this.isCompleted});

  final int index;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
          ),
          child: Center(
            child:
                isCompleted
                    ? Icon(Icons.check, color: Colors.green)
                    : Styles.title(
                      "${index + 1}",
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
          ),
        ),
      ),
    );
  }
}

class LessonUnits extends StatelessWidget {
  const LessonUnits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Units Involved"),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            children: [for (var unit in context.read<Lesson>().units) UnitTile(unit: unit)],
          ),
        ),
      ],
    );
  }
}

class LessonProgression extends StatelessWidget {
  const LessonProgression({super.key});

  @override
  Widget build(BuildContext context) {
    var Lesson(:id, :name, :units, :chapters, :color, :chapterCount, :questionCount) =
        context.read();

    var chaptersDone = context.select<UserDataBloc, int>(
      (bloc) => bloc.state.finishedChapters.where((n) => n.startsWith(id)).length,
    );
    var questionsDone = context.select<UserDataBloc, int>(
      (bloc) => bloc.state.finishedChapters
          /// We only take the tags that start with this lesson
          .where((n) => n.startsWith(id))
          /// We take the string indices
          .map((v) => v.substring(id.length + 1))
          /// We parse the indices to integers
          .map((s) => int.parse(s))
          /// We get the chapter object from the lesson object, reading the questionCount.
          .map((s) => chapters[s].questionCount)
          /// And we sum them all up.
          .fold(0, (a, b) => a + b),
    );

    var questionsTotal = chapters.map((c) => c.questionCount).fold(0, (a, b) => a + b);
    var progressBarValue = questionsTotal == 0 ? 0.0 : questionsDone / questionsTotal;

    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Progression"),
        LinearProgressIndicator(value: progressBarValue, color: color),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Styles.body(
              "$chaptersDone / $chapterCount chapters",
              color: color,
              textAlign: TextAlign.right,
            ),
            Styles.body(
              "$questionsDone / $questionCount questions",
              color: color,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ],
    );
  }
}
