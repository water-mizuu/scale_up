import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LessonsPage/lessons_page_cubit.dart";

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<LessonsPageCubit>().updateType(value),
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
