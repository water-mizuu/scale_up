import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            UserBar(),
            Column(
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchBar(),
                FeaturedCourseContainer(),
                OngoingCoursesContainer(),
                ExploreCoursesContainer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OngoingCoursesContainer extends StatelessWidget {
  const OngoingCoursesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ongoing Courses",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: Text("See All")),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      CourseTile(
                          label: "Distance",
                          icon: Icons.straighten,
                          progressBarValue: 0.2),
                      CourseTile(
                          label: "Temperature",
                          icon: Icons.thermostat,
                          progressBarValue: 0.7),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ExploreCoursesContainer extends StatelessWidget {
  const ExploreCoursesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Explore New Courses",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: Text("See All")),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      CourseTile(
                          label: "Placeholder",
                          icon: Icons.straighten,
                          progressBarValue: 0.0),
                      CourseTile(
                          label: "Placeholder",
                          icon: Icons.thermostat,
                          progressBarValue: 0.0),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FeaturedCourseContainer extends StatelessWidget {
  const FeaturedCourseContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.0,
      children: [
        Text('Daily Practice', style: TextStyle(fontWeight: FontWeight.bold)),
        FeaturedCourse(),
      ],
    );
  }
}

class FeaturedCourse extends StatelessWidget {
  const FeaturedCourse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: CourseTile(
        label: 'Area',
        icon: Icons.square_foot,
        progressBarValue: 0.73,
      ),
      // child: InkWell(
      //   onTap: () {},
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             "Volume",
      //             style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           Text(
      //             "Let us do something rawr",
      //             style: TextStyle(
      //               fontSize: 14,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Image.asset(
      //         "assets/illustrations/topic.png",
      //         height: 80,
      //         fit: BoxFit.cover,
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

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

class CourseTile extends StatelessWidget {
  const CourseTile(
      {required this.label,
      required this.icon,
      required this.progressBarValue,
      super.key});

  final IconData icon;
  final String label;
  final double progressBarValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                spacing: 8,
                children: [
                  Icon(icon),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "Progress",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              LinearProgressIndicator(
                value: progressBarValue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class UserBar extends StatelessWidget {
  const UserBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.0,
            children: [
              Text(
                'Hello, User!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              Text(
                'Welcome back',
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        IconButton.filled(
          onPressed: () {},
          padding: EdgeInsets.all(12.0),
          color: Colors.black,
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white)),
          icon: Icon(Icons.notifications),
        ),
        CircleAvatar(radius: 22.0, child: Text('X'))
      ],
    );
  }
}
