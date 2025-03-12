import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../help/help_page.dart';
import '../login/login_page.dart';
import '../login/register_page.dart';
import '../menu/home_page.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: LoginPage.name,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/help',
        name: HelpPage.name,
        builder: (context, state) => HelpPage(),
      ),
      GoRoute(
        path: '/register',
        name: RegisterPage.name,
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/menu',
        name: HomePage.name,
        builder: (context, state) => HomePage(),
      ),
    ],
    // redirect: _guard,
  );

  static String? _guard(BuildContext context, GoRouterState state) {
    final publicLocations = [
      '/login',
      '/register'
      '/help'
    ];

    return null;
  }
}
