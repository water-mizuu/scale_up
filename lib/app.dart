import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
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
  static const FirestoreHelper _firestoreHelper = FirestoreHelper();

  late final Future<LessonsHelper> _lessonHelperFuture;
  late final FirebaseAuthHelper _firebaseAuthHelper;

  @override
  void initState() {
    super.initState();

    _lessonHelperFuture = LessonsHelper.createAsync();
    _firebaseAuthHelper = FirebaseAuthHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _lessonHelperFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        return MultiProvider(
          providers: [
            InheritedProvider.value(value: snapshot.data!),
            BlocProvider(create: (_) => AuthenticationBloc(repository: _firebaseAuthHelper)),
            BlocProvider(create: (_) => UserDataBloc(firestoreHelper: _firestoreHelper)),
          ],
          builder: (context, _) {
            late var authenticationBloc = context.read<AuthenticationBloc>();
            late var userDataBloc = context.read<UserDataBloc>();

            /// We only want to listen if firebase itself initiated a token change.

            return MultiBlocListener(
              listeners: [
                BlocListener<UserDataBloc, UserDataState>(
                  bloc: userDataBloc,
                  listener: (context, state) async {
                    if (state.status == UserDataStatus.loaded) {
                      await Future.delayed(2.seconds);
                      router.goNamed(AppRoutes.home);
                    }
                  },
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  bloc: authenticationBloc,
                  listenWhen: (p, _) => p.status == AuthenticationStatus.tokenChanging,
                  listener: (_, state) {
                    if (state.status == AuthenticationStatus.signedIn) {
                      router.go("/blank");
                    } else if (state.status == AuthenticationStatus.signedOut) {
                      router.goNamed(AppRoutes.login);
                    }
                  },
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  bloc: authenticationBloc,
                  listenWhen: (p, n) => ((p.user == null) ^ (n.user == null)),
                  listener: (context, state) {
                    if (state.user case var user?) {
                      userDataBloc.add(SignedInUserDataEvent(user: user));
                    } else {
                      userDataBloc.add(SignedOutUserDataEvent());
                    }
                  },
                ),
              ],
              child: AppView(),
            );
          },
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
