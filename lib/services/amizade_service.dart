import 'dart:convert';
import 'package:http/http.dart' as http;

class AmizadeService {
  final String baseUrl = 'http://localhost:8080/usuarios/amizades';

  Future<void> enviarSolicitacao(String email) async {
    final response = await http.post(Uri.parse('$baseUrl/$email'));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao enviar solicitação');
    }
  }

  Future<void> aceitarSolicitacao(String amizadeId) async {
    final response = await http.put(Uri.parse('$baseUrl/$amizadeId'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao aceitar pedido');
    }
  }

  Future<List<Map<String, dynamic>>> listarPendentes() async {
    final response = await http.get(Uri.parse('$baseUrl/pendentes'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao listar pendentes');
    }
  }

  Future<List<Map<String, dynamic>>> listarAceitos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao listar amigos');
    }
  }
}
