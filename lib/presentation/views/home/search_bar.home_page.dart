import "package:flutter/material.dart";

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
