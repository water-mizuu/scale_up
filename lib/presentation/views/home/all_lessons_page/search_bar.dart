import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/all_lessons_page/all_lessons_page_cubit.dart";

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: context.read<FocusNode>(),
      onChanged: (value) => context.read<AllLessonsPageCubit>().updateType(value),
      decoration: const InputDecoration(
        prefixIcon: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.search, size: 18)),
        border: OutlineInputBorder(),
        hintText: "Search",
      ),
    );
  }
}
