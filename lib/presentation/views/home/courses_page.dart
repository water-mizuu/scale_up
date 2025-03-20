import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget{
  const CoursesPage({
    super.key
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text('COURSES PAGE')],
            ),
          ],
        ),
      ),
    );
  }

  
}