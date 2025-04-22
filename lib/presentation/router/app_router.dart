import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/views/authentication/sign_in_page.dart";
import "package:scale_up/presentation/views/authentication/sign_up_page.dart";
import "package:scale_up/presentation/views/home/all_lessons_page.dart";
import "package:scale_up/presentation/views/home/home_page.dart";
import "package:scale_up/presentation/views/home/learn_page.dart";
import "package:scale_up/presentation/views/home/lesson_page.dart";
import "package:scale_up/presentation/views/home/practice_page.dart";
import "package:scale_up/presentation/views/home/profile_page.dart";
import "package:scale_up/presentation/views/home/splash_page.dart";
import "package:scale_up/presentation/views/home/widgets/app_scaffold.dart";

class AppRoutes {
  static const String login = "login";
  static const String signUp = "signup";
  static const String home = "home";
  static const String profile = "profile";
  static const String lesson = "lesson";
  static const String allLessons = "all_lessons";
  static const String allLessonsSearch = "all_lessons_search";
  static const String learn = "learn";
  static const String practice = "practice";

  static const String _blank = "/blank";
}

// ignore: unused_element
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes._blank,
  routes: [
    /// We add a blank route to have the application load this screen first.
    GoRoute(path: AppRoutes._blank, builder: (context, state) => SplashPage()),
    GoRoute(
      path: "/login",
      name: AppRoutes.login,
      builder: (context, state) => const SignInPage(),
      routes: [
        GoRoute(
          path: "register",
          name: AppRoutes.signUp,
          builder: (context, state) => const SignUpPage(),
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: "/home", //
          name: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: "/all_lessons",
          name: AppRoutes.allLessons,
          builder: (context, state) => const AllLessonsPage(isFromSearch: false),
          routes: [
            GoRoute(
              path: "from_search",
              name: AppRoutes.allLessonsSearch,
              builder: (context, state) => const AllLessonsPage(isFromSearch: true),
            ),

            GoRoute(
              path: ":id",
              name: AppRoutes.lesson,
              builder: (context, state) {
                var lessonId = state.pathParameters["id"];
                assert(lessonId != null, "Lesson ID cannot be null");

                return LessonPage(id: lessonId!);
              },
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: "learn/:chapterIndex",
                  name: AppRoutes.learn,
                  builder: (context, state) {
                    var lessonId = state.pathParameters["id"];
                    var chapterIndex = state.pathParameters["chapterIndex"];
                    assert(lessonId != null, "Lesson ID cannot be null");
                    assert(chapterIndex != null, "Chapter index cannot be null");

                    return LearnPage(lessonId: lessonId!, chapterIndex: int.parse(chapterIndex!));
                  },
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: "practice/:chapterIndex",
                  name: AppRoutes.practice,
                  builder: (context, state) {
                    var lessonId = state.pathParameters["id"];
                    var chapterIndex = state.pathParameters["chapterIndex"];
                    assert(lessonId != null, "Lesson ID cannot be null");
                    assert(chapterIndex != null, "Chapter index cannot be null");

                    return PracticePage(
                      lessonId: lessonId!,
                      chapterIndex: int.parse(chapterIndex!),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: "/profile",
          name: AppRoutes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);
