import 'package:festora/config/api_config.dart';
import 'package:festora/pages/login/login_page.dart';
import 'package:festora/pages/login/register_page.dart';
import 'package:festora/pages/menu/home_page.dart';
import 'package:festora/utils/TokenHelper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class TokenService {
  static Future<void> verificarToken(BuildContext context) async {
    String? token = await TokenHelper.getToken();

    if (token == null) {
      // Sem token => vai pro login
      _redirecionarParaLogin(context);
      return;
    }

    final url = Uri.parse('${ApiConfig.baseUrl}/usuarios/verificarToken');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final currentRoute = ModalRoute.of(context)?.settings.name;

    if (response.statusCode == 200) {
      // Token válido
      if (currentRoute == LoginPage.name || currentRoute == RegisterPage.name) {
        context.goNamed(HomePage.name);
      }
    } else {
      // Token inválido => sempre manda pro login
      _redirecionarParaLogin(context);
    }
  }

  static void _redirecionarParaLogin(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != LoginPage.name && currentRoute != RegisterPage.name) {
        context.goNamed(LoginPage.name);
    }
  }
}
