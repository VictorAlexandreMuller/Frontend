import 'package:festora/models/evento_model.dart';
import 'package:festora/pages/menu/buscar_page.dart';
import 'package:festora/pages/menu/listagem_page.dart';
import 'package:festora/pages/menu/perfil_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../help/help_page.dart';
import '../login/login_page.dart';
import '../login/register_page.dart';
import '../event/criar_editar/criar_editar_evento__page.dart';
import '../event/ver_evento/detalhes_evento_page.dart';
import '../menu/home_section_page.dart';

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
        name: HomeSectionPage.name,
        builder: (context, state) => const HomeSectionPage(),
      ),

      // 🍵 CRIAÇÃO E EDIÇÃO UNIFICADAS
      GoRoute(
        path: '/criar-evento',
        name: 'criar-evento',
        builder: (context, state) {
          final extra = state.extra;
          if (extra is EventoModel) {
            return CriarEventoPage(evento: extra);
          } else if (extra is String) {
            return CriarEventoPage(tipoEvento: extra);
          } else {
            return const Scaffold(
              body: Center(
                  child: Text('Parâmetro inválido para criação de evento')),
            );
          }
        },
      ),

      // 📄 DETALHES DO EVENTO
      GoRoute(
        path: '/detalhes-evento',
        name: DetalhesEventoPage.routeName, // 'detalhes-evento'
        builder: (context, state) {
          final extra = state.extra;
          if (extra is EventoModel) {
            return DetalhesEventoPage(evento: extra);
          } else {
            return const Scaffold(
              body: Center(child: Text('Evento não encontrado.')),
            );
          }
        },
      ),
    ],
  );
}
