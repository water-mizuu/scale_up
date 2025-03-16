import 'package:go_router/go_router.dart';
import 'package:scale_up/presentation/views/authentication/login_page.dart';
import 'package:scale_up/presentation/views/authentication/sign_up_page.dart';
import 'package:scale_up/presentation/views/home/home_page.dart';

class AppRoutes {
  static const String loginPath = '/login';
  static const String signUpPath = '/register';
  static const String homePath = '/home';
}

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.loginPath,
  routes: [
    GoRoute(
        path: AppRoutes.loginPath,
        name: 'login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: AppRoutes.signUpPath,
            name: 'signup',
            builder: (context, state) => const SignUpPage(),
          ),
        ]),
    GoRoute(
      path: AppRoutes.homePath,
      name: 'home',
      builder: (context, state) => const HomePage(),
    )
  ],
);
