import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDataBloc, UserDataState>(
      listener: (context, state) {
        if (state.status == UserDataStatus.loaded) {
          context.goNamed(AppRoutes.home);
        }
      },
      child: Material(child: Center(child: Text("Loading..."))),
    );
  }
}
