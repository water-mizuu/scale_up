import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/views/authentication/login_page.dart";
import "package:scale_up/presentation/views/authentication/sign_up_page.dart";
import "package:scale_up/presentation/views/home/all_lessons_page.dart";
import "package:scale_up/presentation/views/home/app_scaffold.dart";
import "package:scale_up/presentation/views/home/home_page.dart";
import "package:scale_up/presentation/views/home/lesson_page.dart";
import "package:scale_up/presentation/views/home/profile_page.dart";

class AppRoutes {
  static const String loginPath = "/login";
  static const String signUpPath = "/register";
  static const String homePath = "/home";
  static const String allLessonsPath = "/lessons";
  static const String profilePath = "/profile";
  static const String lessonPath = "/lessons/:id";

  static const String login = "login";
  static const String signUp = "signup";
  static const String home = "home";
  static const String allLessons = "lessons";
  static const String profile = "profile";
  static const String lesson = "lesson";

  static const String _blank = "/blank";
}

// ignore: unused_element
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes._blank,
  routes: [
    /// We add a blank route to have the application load this screen first.
    GoRoute(
      path: AppRoutes._blank,
      builder: (context, state) => const Material(),
    ),
    GoRoute(
      path: AppRoutes.loginPath,
      name: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: AppRoutes.signUpPath,
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
          path: AppRoutes.homePath,
          name: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.allLessonsPath,
          name: AppRoutes.allLessons,
          builder: (context, state) => const LessonsPage(),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: AppRoutes.lessonPath,
              name: AppRoutes.lesson,
              builder: (context, state) {
                var lessonId = state.pathParameters["id"];
                assert(lessonId != null, "Lesson ID cannot be null");

                return LessonPage(id: lessonId!);
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.profilePath,
          name: AppRoutes.profile,
          builder: (context, state) => const ProfilePage(),
        )
      ],
    ),
  ],
);
