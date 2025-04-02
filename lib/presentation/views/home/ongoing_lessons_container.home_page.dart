import "package:flutter/material.dart";

class OngoingLessonsContainer extends StatelessWidget {
  const OngoingLessonsContainer({
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
              "Ongoing Lessons",
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
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: <Widget>[],
          ),
        ),
      ],
    );
  }
}
