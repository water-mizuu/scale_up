import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_up/presentation/bloc/CoursesPage/courses_page_cubit.dart';
import 'package:scale_up/presentation/views/authentication/widgets/course_tile.dart';
import 'package:scale_up/presentation/widgets/styles.dart';

typedef Category = ({
  String label,
  String? sublabel,
  IconData icon,
  int questionsDone,
  int questionsTotal,
  double progressBarValue,
  Color baseColor,
  Set<String> unitsInvolved,
});
final List<Category> categories = [
  (
    label: "Length",
    sublabel: "Meters",
    icon: Icons.straighten,
    questionsDone: 3,
    questionsTotal: 10,
    progressBarValue: 0.3,
    baseColor: Colors.blue,
    unitsInvolved: {"m", "cm", "mm"}.lowercase,
  ),
  (
    label: "Length",
    sublabel: "Miles",
    icon: Icons.directions_run,
    questionsDone: 5,
    questionsTotal: 15,
    progressBarValue: 0.33,
    baseColor: Colors.blueAccent,
    unitsInvolved: {"mi", "yd", "ft"}.lowercase,
  ),
  (
    label: "Area",
    sublabel: "Square Meters",
    icon: Icons.crop_square,
    questionsDone: 7,
    questionsTotal: 12,
    progressBarValue: 0.58,
    baseColor: Colors.green,
    unitsInvolved: {"m²", "cm²"}.lowercase,
  ),
  (
    label: "Volume",
    sublabel: "Liters",
    icon: Icons.local_drink,
    questionsDone: 2,
    questionsTotal: 8,
    progressBarValue: 0.25,
    baseColor: Colors.orange,
    unitsInvolved: {"L", "mL"}.lowercase,
  ),
  (
    label: "Temperature",
    sublabel: "Celsius",
    icon: Icons.thermostat,
    questionsDone: 10,
    questionsTotal: 10,
    progressBarValue: 1.0,
    baseColor: Colors.red,
    unitsInvolved: {"°C", "°F", "K"}.lowercase,
  ),
  (
    label: "Mass",
    sublabel: "Kilograms",
    icon: Icons.fitness_center,
    questionsDone: 1,
    questionsTotal: 5,
    progressBarValue: 0.2,
    baseColor: Colors.purple,
    unitsInvolved: {"kg", "g", "lb"}.lowercase,
  ),
  (
    label: "Currency",
    sublabel: null, // Optional field demonstration
    icon: Icons.attach_money,
    questionsDone: 4,
    questionsTotal: 9,
    progressBarValue: 0.44,
    baseColor: Colors.teal,
    unitsInvolved: {"USD", "EUR", "GBP"}.lowercase,
  ),
  (
    label: "Time",
    sublabel: "Seconds",
    icon: Icons.timer,
    questionsDone: 8,
    questionsTotal: 10,
    progressBarValue: 0.8,
    baseColor: Colors.indigo,
    unitsInvolved: {"s", "min", "h"}.lowercase,
  ),
  (
    label: "Data",
    sublabel: "Bytes",
    icon: Icons.memory,
    questionsDone: 2,
    questionsTotal: 10,
    progressBarValue: 0.2,
    baseColor: Colors.cyan,
    unitsInvolved: {"B", "KB", "MB"}.lowercase,
  ),
  (
    label: "Energy",
    sublabel: "Joules",
    icon: Icons.flash_on,
    questionsDone: 6,
    questionsTotal: 12,
    progressBarValue: 0.5,
    baseColor: Colors.amber,
    unitsInvolved: {"J", "kJ", "cal"}.lowercase,
  ),
];

int _leveshtein(String s, String t) {
  List<int> v0 = List<int>.generate(t.length + 1, (i) => i);
  List<int> v1 = List<int>.generate(t.length + 1, (i) => 0);

  for (int i = 0; i < s.length; i++) {
    v1[0] = i + 1;

    for (int j = 0; j < t.length; j++) {
      int deletionCost = v0[j + 1] + 1;
      int insertionCost = v1[j] + 1;
      int substitutionCost = s[i] == t[j] ? v0[j] : v0[j] + 1;

      int chosen = [deletionCost, insertionCost, substitutionCost].reduce(min);
      v1[j + 1] = chosen;
    }

    v0 = [...v1];
  }

  return v0[t.length];
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesPageCubit(),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleBar(),
              Expanded(
                child: Column(
                  spacing: 16.0,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SearchBar(),
                    Expanded(child: CourseBody()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseBody extends StatelessWidget {
  const CourseBody({super.key});

  int _score(Set<String> keywords, Map<String, List<Category>> categoriesByTitle, String title) {
    /// It should always return true if there are no keywords being typed.
    if (keywords.isEmpty) {
      return 0;
    }

    int minimum = title.length;

    /// It should return true if there is a partial match between the title and the titles.
    for (String keyword in keywords) {
      minimum = min(minimum, _leveshtein(title.toLowerCase(), keyword));

      for (var Category(:label, :sublabel) in categoriesByTitle[title] ?? []) {
        minimum = min(minimum, _leveshtein(label.toLowerCase(), keyword));

        if (sublabel case String sublabel) {
          minimum = min(minimum, _leveshtein(sublabel.toLowerCase(), keyword));
        }
      }

      for (var unit in categoriesByTitle[title]!.expand((c) => c.unitsInvolved)) {
        minimum = min(minimum, _leveshtein(unit, keyword));
      }
    }

    return minimum;
  }

  @override
  Widget build(BuildContext context) {
    /// TODO: Decide how this will be sorted.
    Set<String> titles = {
      for (Category category in categories) //
        category.label,
    };
    Map<String, List<Category>> categoriesByTitle = {
      for (String title in titles) //
        title: categories.where((c) => c.label == title).toList(),
    };

    return BlocBuilder<CoursesPageCubit, CoursesPageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: ([
              for (String title in titles)
                if (_score(state.keywords, categoriesByTitle, title) case int score
                    when score < title.length / 2)
                  (
                    score,
                    CourseGroup(
                      title: title,
                      categoriesByTitle: categoriesByTitle,
                    )
                  )
            ]..sort((a, b) => a.$1.compareTo(b.$1)))
                .map((w) => w.$2)
                .toList(),
          ),
        );
      },
    );
  }
}

class CourseGroup extends StatelessWidget {
  const CourseGroup({
    super.key,
    required this.title,
    required this.categoriesByTitle,
  });

  final String title;
  final Map<String, List<Category>> categoriesByTitle;

  bool _match(Set<String> keywords, Set<String> units) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesPageCubit, CoursesPageState>(
      builder: (context, state) => Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Styles.title),
          for (Category category in categoriesByTitle[title] ?? [])
            if (_match(state.keywords, category.unitsInvolved))
              CourseTile(
                icon: category.icon,
                label: category.label,
                sublabel: category.sublabel,
                questionsDone: category.questionsDone,
                questionsTotal: category.questionsTotal,
                progressBarValue: category.progressBarValue,
                baseColor: category.baseColor,
              ),
        ],
      ),
    );
  }
}

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "All Courses",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<CoursesPageCubit>().updateType(value),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.search,
            size: 18,
          ),
        ),
        border: OutlineInputBorder(),
        hintText: "Search",
      ),
    );
  }
}

extension on Set<String> {
  Set<String> get lowercase => map((e) => e.toLowerCase()).toSet();
}
