import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/title_case.dart";

class UserBar extends StatelessWidget {
  const UserBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 2.0,
      children: [
        Text("Welcome back", style: TextStyle(fontSize: 12.0), textAlign: TextAlign.start),
        BlocBuilder<UserDataBloc, UserDataState>(
          buildWhen: (p, c) => p.user != c.user,
          builder: (context, state) {
            return Styles.subtitle(
              'Hello, ${(state.user?.displayName ?? "User").toTitleCase()}',
              textAlign: TextAlign.start,
            );
          },
        ),
      ],
    );
  }
}
