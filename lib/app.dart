import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/repositories/authentication/authentication_repository.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scroll_animator/scroll_animator.dart";

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final LessonsRepository _lessonRepository;
  late final AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();

    _authenticationRepository = AuthenticationRepository();
    _lessonRepository = LessonsRepository();
    _authenticationBloc = AuthenticationBloc(repository: _authenticationRepository);
    unawaited(_lessonRepository.initialize());
  }

  @override
  void dispose() {
    _authenticationBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        InheritedProvider.value(value: _lessonRepository),
        BlocProvider.value(value: _authenticationBloc),
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: _authenticationBloc,
        listenWhen: (previous, _) => previous.status == AuthenticationStatus.tokenChanging,
        listener: (context, state) {
          if (kDebugMode) {
            print("Hi ${state.status}");
          }
          if (state.status == AuthenticationStatus.signedIn) {
            // Navigate to the home screen
            router.goNamed(AppRoutes.home);
          } else if (state.status == AuthenticationStatus.signedOut) {
            // Navigate to the login screen
            router.goNamed(AppRoutes.login);
          }
        },
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      actions: {...WidgetsApp.defaultActions, ScrollIntent: AnimatedScrollAction()},
      routerConfig: router,
    );
  }
}
