import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:scale_up/presentation/views/authentication/widgets/course_tile.dart';
import 'package:scale_up/presentation/views/home/widgets/styles.dart';

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
            Expanded(
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SearchBar(),
                  FeaturedCourseContainer(),
                  OngoingCoursesContainer(),
                  ExploreCoursesContainer(),
                ],
              ),
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
      spacing: 8.0,
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: <Widget>[
              CourseTile(
                label: "Distance",
                sublabel: "Unit 1",
                questionsDone: 7,
                questionsTotal: 10,
                icon: Icons.straighten,
                baseColor: Colors.pink,
                progressBarValue: 0.2,
              ),
              CourseTile(
                label: "Temperature",
                questionsDone: 7,
                questionsTotal: 10,
                baseColor: Colors.orange,
                icon: Icons.thermostat,
                progressBarValue: 0.7,
              ),
              CourseTile(
                label: "Temperature",
                questionsDone: 7,
                questionsTotal: 10,
                baseColor: Colors.green,
                icon: Icons.thermostat,
                progressBarValue: 0.7,
              ),
            ],
          ),
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
      spacing: 8.0,
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              CourseTile(
                label: "Placeholder",
                questionsDone: 7,
                questionsTotal: 10,
                icon: Icons.straighten,
                progressBarValue: 0.0,
                baseColor: Colors.blueAccent,
              ),
              CourseTile(
                label: "Placeholder 3",
                sublabel: "Sublabel what if i have a long subtitle",
                questionsDone: 7,
                questionsTotal: 10,
                icon: Icons.thermostat,
                progressBarValue: 0.0,
                baseColor: Colors.blueAccent,
              ),
              CourseTile(
                label: "Placeholder 2",
                sublabel: "Sublabel what if i have a long subtitle",
                questionsDone: 7,
                questionsTotal: 10,
                icon: Icons.thermostat,
                progressBarValue: 1.0,
                baseColor: Colors.blueAccent,
              ),
            ],
          ),
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
  const FeaturedCourse({super.key});

  @override
  Widget build(BuildContext context) {
    /// TODO: Base this featured course from something else.
    return CourseTile(
      label: 'Area',
      questionsDone: 4,
      questionsTotal: 5,
      icon: Icons.square_foot,
      progressBarValue: 0.73,
      baseColor: Colors.blueAccent,
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

class UserBar extends StatelessWidget {
  const UserBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.0,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.start,
              ),
              StreamBuilder(
                stream: firebase_auth.FirebaseAuth.instance.userChanges(),
                builder: (context, snapshot) {
                  var user = firebase_auth.FirebaseAuth.instance.currentUser;

                  return Text(
                    'Hello, ${(user?.displayName ?? "User").toLowerCase()}',
                    style: Styles.subtitle,
                    textAlign: TextAlign.start,
                  );
                },
              ),
            ],
          ),
        ),
        Ink(
          decoration: ShapeDecoration(
            color: Colors.blue,
            shape: CircleBorder(),
          ),
          child: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
      ],
    );
  }
}
