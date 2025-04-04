import "package:flutter/material.dart";

class ExploreLessonsContainer extends StatelessWidget {
  const ExploreLessonsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Explore New Lessons",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: Text("See All")),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [],
          ),
        ),
      ],
    );
  }
}
