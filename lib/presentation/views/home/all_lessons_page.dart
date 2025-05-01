import "package:flutter/material.dart" hide SearchBar;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/AllLessonsPage/all_lessons_page_cubit.dart";
import "package:scale_up/presentation/views/home/all_lessons_page/all_lessons_body.dart";
import "package:scale_up/presentation/views/home/all_lessons_page/search_bar.dart";
import "package:scale_up/presentation/views/home/all_lessons_page/title_bar.dart";

class AllLessonsPage extends StatefulWidget {
  const AllLessonsPage({required this.isFromSearch, super.key});

  final bool isFromSearch;

  @override
  State<AllLessonsPage> createState() => _AllLessonsPageState();
}

class _AllLessonsPageState extends State<AllLessonsPage> {
  late final FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();

    searchFocusNode = FocusNode();
    if (widget.isFromSearch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchFocusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    searchFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var helper = context.read<LessonsHelper>();
    var lessons = helper.lessons;
    if (lessons.isEmpty) {
      return const Center(child: Text("No lessons available"));
    }

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => AllLessonsPageCubit(helper, lessons)),
        InheritedProvider.value(value: searchFocusNode),
      ],
      child: AllLessonsPageView(),
    );
  }
}

class AllLessonsPageView extends StatelessWidget {
  const AllLessonsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true, elevation: 0, scrolledUnderElevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0) - const EdgeInsets.only(bottom: 16.0),
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleBar(),
            Expanded(
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [SearchBar(), Expanded(child: AllLessonsBody())],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
