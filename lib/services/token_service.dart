import 'package:festora/config/api_config.dart';
import 'package:festora/pages/login/login_page.dart';
import 'package:festora/pages/login/register_page.dart';
import 'package:festora/pages/menu/home_page.dart';
import 'package:festora/utils/TokenHelper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  // Verifica se o token é válido
  static Future<void> verificarToken(BuildContext context) async {
    String? token = await TokenHelper.getToken();

    if (token == null) {
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

    if (response.statusCode != 200) {
      _redirecionarParaLogin(context);
    }
  }

  // Limpa o token salvo
  static Future<void> limparToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Faz o logout completo
  static Future<void> logout(BuildContext context) async {
    await limparToken();
    context.goNamed(LoginPage.name);
  }

  // Redireciona para login, se não estiver já lá
  static void _redirecionarParaLogin(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != LoginPage.name && currentRoute != RegisterPage.name) {
      context.goNamed(LoginPage.name);
    }
  }
}
