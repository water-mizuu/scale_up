import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/firebase/firebase_auth_helper.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scroll_animator/scroll_animator.dart";

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late final FirestoreHelper _firestoreHelper;
  late final FirebaseAuthHelper _firebaseAuthHelper;
  late final LessonsHelper _lessonRepository;

  @override
  void initState() {
    super.initState();

    _firestoreHelper = const FirestoreHelper();
    _firebaseAuthHelper = FirebaseAuthHelper();
    _lessonRepository = LessonsHelper();
    unawaited(_lessonRepository.initialize());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        InheritedProvider.value(value: _lessonRepository),
        BlocProvider(create: (_) => AuthenticationBloc(repository: _firebaseAuthHelper)),
        BlocProvider(create: (_) => UserDataBloc(firestoreHelper: _firestoreHelper)),
      ],
      builder: (context, _) {
        late var authenticationBloc = context.read<AuthenticationBloc>();
        late var userDataBloc = context.read<UserDataBloc>();

        /// We only want to listen if firebase itself initiated a token change.
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          listenWhen: (previous, _) => previous.status == AuthenticationStatus.tokenChanging,
          listener: (context, state) {
            if (state.status == AuthenticationStatus.signedIn) {
              router.goNamed(AppRoutes.home);
            } else if (state.status == AuthenticationStatus.signedOut) {
              // Navigate to the login screen
              router.goNamed(AppRoutes.login);
            }
          },

          /// This listener is for when a user logs in or logs out.
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            listenWhen: (p, n) => ((p.user == null) ^ (n.user == null)),
            listener: (context, state) {
              if (state.user case var user?) {
                userDataBloc.add(SignedInUserDataEvent(user: user));
              } else {
                userDataBloc.add(SignedOutUserDataEvent());
              }
            },
            child: AppView(),
          ),
        );
      },
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
