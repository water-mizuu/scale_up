import "dart:ui";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:scale_up/data/sources/firebase/firebase_auth_helper.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/hooks/providing_hook_widget.dart";
import "package:scale_up/hooks/use_bloc_listener.dart";
import "package:scale_up/hooks/use_new_bloc.dart";
import "package:scale_up/presentation/bloc/authentication/authentication_bloc.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/router/app_router.dart";
import "package:scroll_animator/scroll_animator.dart";

class App extends ProvidingHookWidget {
  const App({super.key});

  static const FirestoreHelper _firestoreHelper = FirestoreHelper();

  @override
  Widget build(BuildContext context) {
    final lessonsHelperFuture = useMemoized(() => LessonsHelper.createAsync());
    final authHelper = useMemoized(() => FirebaseAuthHelper());
    final snapshot = useFuture(lessonsHelperFuture);

    if (snapshot.hasError) {
      if (kDebugMode) {
        print("Error loading lessons: ${snapshot.error}");
        print(snapshot.stackTrace);
      }
    }

    if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
      return const Material(color: Colors.white);
    }

    return LoadedApp(
      lessonsHelper: snapshot.data!,
      authHelper: authHelper,
      firestoreHelper: _firestoreHelper,
    );
  }
}

class LoadedApp extends ProvidingHookWidget {
  const LoadedApp({
    super.key,
    required this.lessonsHelper,
    required this.authHelper,
    required FirestoreHelper firestoreHelper,
  }) : _firestoreHelper = firestoreHelper;

  final LessonsHelper lessonsHelper;
  final FirebaseAuthHelper authHelper;
  final FirestoreHelper _firestoreHelper;

  @override
  Widget build(BuildContext context) {
    /// We expose the lessons helper to the tree
    ///  after it is loaded.
    context.provide(lessonsHelper);

    final isFirstLoad = useState(true);
    var authenticationBloc = useCreateBloc(() => AuthenticationBloc(repository: authHelper));
    context.provideBloc(authenticationBloc);

    var userDataBloc = useCreateBloc(() => UserDataBloc(firestoreHelper: _firestoreHelper));
    context.provideBloc(userDataBloc);

    useBlocListener(userDataBloc, (state) async {
      if (state.user == null) return;

      if (state.status == UserDataStatus.loaded) {
        if (kDebugMode) {
          print("Going home due to user bloc change");
        }
        router.goNamed(AppRoutes.home);
      }
    }, listenWhen: (p, c) => p.status != c.status);

    useBlocListener(
      authenticationBloc,
      (state) {
        if (kDebugMode) {
          print((isFirstLoad: isFirstLoad));
        }

        if (state.user case var user?) {
          if (kDebugMode) {
            print("User changed: $user");
          }
          userDataBloc.add(SignedInUserDataEvent(user: user));

          if (isFirstLoad.value) {
            isFirstLoad.value = false;
            router.go("/blank");
          } else {
            router.go(AppRoutes.loading);
          }
        } else {
          if (kDebugMode) {
            print("User changed: null");
          }
          userDataBloc.add(const SignedOutUserDataEvent());

          if (isFirstLoad.value) {
            isFirstLoad.value = false;
            router.go("/blank");
          } else {
            router.goNamed(AppRoutes.login);
          }
        }
      },
      listenWhen:
          (p, n) =>
              p.status == AuthenticationStatus.tokenChanging ||
              (p.user == null) ^ (n.user == null),
      keys: [isFirstLoad],
    );

    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget widget = MaterialApp.router(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black) //
        .copyWith(surface: const Color(0xFFF7F8F9)),
        useMaterial3: true,
      ),

      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      debugShowCheckedModeBanner: false,
      actions: {...WidgetsApp.defaultActions, ScrollIntent: AnimatedScrollAction()},
      routerConfig: router,
    );

    if (kIsWeb) {
      /// This allows the application to be tested on a web browser
      ///   While being in a mobile layout.
      /// This is useful for testing purposes only, and should not be used in production.
      var size = MediaQuery.sizeOf(context);
      if (size.width / size.height > 0.6) {
        widget = Center(
          child: Container(
            height: 820,
            width: 380,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: widget,
          ),
        );
      }
    }

    return widget;
  }
}
