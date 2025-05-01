import "dart:async";
import "dart:ui";

import "package:flutter/foundation.dart";
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
        if (snapshot.hasError) {
          if (kDebugMode) {
            print("Error loading lessons: ${snapshot.error}");
          }
        }

        if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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

            return MultiBlocListener(
              listeners: [
                BlocListener<UserDataBloc, UserDataState>(
                  bloc: userDataBloc,
                  listenWhen: (p, c) => p.status != c.status,
                  listener: (context, state) async {
                    if (state.user == null) return;

                    if (state.status == UserDataStatus.loaded) {
                      if (kDebugMode) {
                        print("Going home due to user bloc change");
                      }
                      router.goNamed(AppRoutes.home);
                    }
                  },
                ),

                /// We only want to listen if firebase itself initiated a token change.
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  bloc: authenticationBloc,
                  listenWhen: (p, _) => p.status == AuthenticationStatus.tokenChanging,
                  listener: (_, state) {
                    if (state.status == AuthenticationStatus.signedIn) {
                      if (kDebugMode) {
                        print("Going to splash as signed in.");
                      }
                      router.go("/blank");
                    } else if (state.status == AuthenticationStatus.signedOut) {
                      if (kDebugMode) {
                        print("Going to login as signed out by token.");
                      }
                      router.goNamed(AppRoutes.login);
                    }
                  },
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  bloc: authenticationBloc,
                  listenWhen: (p, n) => (p.user == null) ^ (n.user == null),
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
    Widget child = MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black) //
        .copyWith(surface: const Color(0xFFF7F8F9)),
      ),
      scrollBehavior: MaterialScrollBehavior() //
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      debugShowCheckedModeBanner: false,
      actions: {...WidgetsApp.defaultActions, ScrollIntent: AnimatedScrollAction()},
      routerConfig: router,
    );

    if (kIsWeb) {
      /// This allows the application to be tested on a web browser
      ///   While being in a mobile layout.
      /// This is useful for testing purposes only, and should not be used in production.
      child = Center(
        child: Container(
          height: 820,
          width: 380,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: child,
        ),
      );
    }

    return child;
  }
}
