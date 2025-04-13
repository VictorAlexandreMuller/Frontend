import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../help/help_page.dart';
import '../login/login_page.dart';
import '../login/register_page.dart';
import '../menu/home_page.dart';

import '../../pages/event/criar/criacao_cha_fraldas_page.dart';
import '../../pages/event/criar/criacao_cha_revelacao_page.dart';
import '../../pages/event/criar/criacao_cha_bebe_page.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: LoginPage.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/help',
        name: HelpPage.name,
        builder: (context, state) => const HelpPage(),
      ),
      GoRoute(
        path: '/register',
        name: RegisterPage.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/menu',
        name: HomePage.name,
        builder: (context, state) => const HomePage(),
      ),

      // 🍵 ROTAS DE CRIAÇÃO DE CHÁS
      GoRoute(
        path: CriarChaBebePage.routeName,
        name: 'criar-cha-bebe',
        builder: (context, state) => const CriarChaBebePage(),
      ),
      GoRoute(
        path: CriarChaRevelacaoPage.routeName,
        name: 'criar-cha-revelacao',
        builder: (context, state) => const CriarChaRevelacaoPage(),
      ),
      GoRoute(
        path: CriarChaFraldasPage.routeName,
        name: 'criar-cha-fraldas',
        builder: (context, state) => const CriarChaFraldasPage(),
      ),
    ],
    // redirect: _guard,
  );

  static String? _guard(BuildContext context, GoRouterState state) {
    final publicLocations = [
      '/login',
      '/register',
      '/help',
    ];
    return null;
  }
}
