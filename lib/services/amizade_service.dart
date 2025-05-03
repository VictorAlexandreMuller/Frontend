import 'dart:convert';
import 'dart:io';

import 'package:festora/services/token_service.dart';
import 'package:http/http.dart' as http;

/// Classe que detecta se está rodando em emulador/web ou celular real
class ApiConfig {
  static String get baseUrl {
    // Use localhost para ambiente de desenvolvimento web ou emulador Android
    if (Platform.isAndroid || Platform.isIOS) {
      return 'http://192.168.71.222:8080';
    } else {
      return 'http://localhost:8080';
    }
  }
}

class AmizadeService {
  final String baseUrl = '${ApiConfig.baseUrl}/usuarios/amizades';

  Future<void> enviarSolicitacao(String email) async {
    final response = await http
        .post(Uri.parse('$baseUrl/$email'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao enviar solicitação');
    }
  }

  Future<void> aceitarSolicitacao(String amizadeId) async {
    final response = await http
        .put(Uri.parse('$baseUrl/$amizadeId'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('Erro ao aceitar pedido');
    }
  }

  Future<List<Map<String, dynamic>>> listarPendentes() async {
    final response = await http
        .get(Uri.parse('$baseUrl/pendentes'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao listar pendentes');
    }
  }

  Future<List<Map<String, dynamic>>> listarAceitos() async {
    final url = Uri.parse(baseUrl);
    final token = await TokenService.obterToken();

    print('Chamando: $url');
    print('Token: $token');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Erro ao buscar amizades');
    }
  }
}
