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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text('Daily Practice')],
            ),
            Row(
              children: [
                Expanded(
                  child: Card.filled(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
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
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)),
          icon: Icon(Icons.notifications),
        ),
        CircleAvatar(radius: 22.0, child: Text('U'))
      ],
    );
  }
}
