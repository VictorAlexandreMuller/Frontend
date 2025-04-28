import 'package:festora/models/evento_model.dart';
import 'package:festora/pages/event/editar/editar_evento_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../help/help_page.dart';
import '../login/login_page.dart';
import '../login/register_page.dart';
import '../menu/home_page.dart';

import '../event/criar/criacao_evento__page.dart';

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
        path: '/criar-evento',
        name: 'criar-evento',
        builder: (context, state) {
          final tipoEvento = state.extra as String;
          return CriarEventoPage(tipoEvento: tipoEvento);
        },
      ),
      GoRoute(
        path: '/editar-evento',
        name: EditarEventoPage.name,
        builder: (context, state) {
          final evento = state.extra as EventoModel;
          return EditarEventoPage(evento: evento);
        },
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
