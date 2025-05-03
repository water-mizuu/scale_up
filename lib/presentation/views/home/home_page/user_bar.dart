import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/empty_as_null_extension.dart";
import "package:scale_up/utils/extensions/title_case_extension.dart";

class UserBar extends StatelessWidget {
  const UserBar({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.select((UserDataBloc b) => b.state.user);

    return Row(
      children: [
        Styles.title("Hello, ", fontSize: 20, textAlign: TextAlign.start),
        Styles.title(
          "${(user?.displayName?.emptyAsNull ?? "User").toTitleCase()}!",
          fontSize: 20,
          textAlign: TextAlign.start,
          color: const Color.fromARGB(255, 45, 103, 47),
        ),
      ],
    );
  }
}
