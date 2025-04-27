import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/title_case.dart";

class UserBar extends StatelessWidget {
  const UserBar({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.select((UserDataBloc b) => b.state.user);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 2.0,
      children: [
        // Text("Welcome back", style: TextStyle(fontSize: 12.0), textAlign: TextAlign.start),
        Row(
          children: [
            Styles.title("Hello, ", fontSize: 20, textAlign: TextAlign.start),
            Styles.title(
              "${(user?.displayName ?? "User").toTitleCase()}!",
              fontSize: 20,
              textAlign: TextAlign.start,
              color: const Color.fromARGB(255, 45, 103, 47),
            ),
          ],
        ),
      ],
    );
  }
}
