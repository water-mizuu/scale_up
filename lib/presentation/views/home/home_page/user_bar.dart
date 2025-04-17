import "package:firebase_auth/firebase_auth.dart" as firebase_auth;
import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/title_case.dart";

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
                "Welcome back",
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.start,
              ),
              StreamBuilder(
                stream: firebase_auth.FirebaseAuth.instance.userChanges(),
                builder: (context, snapshot) {
                  var user = firebase_auth.FirebaseAuth.instance.currentUser;

                  return Styles.subtitle(
                    'Hello, ${(user?.displayName ?? "User").toTitleCase()}',
                    textAlign: TextAlign.start,
                  );
                },
              ),
            ],
          ),
        ),
        Ink(
          decoration: ShapeDecoration(color: Colors.blue, shape: CircleBorder()),
          child: CircleAvatar(child: Icon(Icons.person)),
        ),
      ],
    );
  }
}
