import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../login/login_page.dart';
import '../menu/home_page.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      // GoRoute(
      //   path: '/help',
      //   builder: (context, state) => HelpPage(),
      // ),
      GoRoute(
        path: '/menu',
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
