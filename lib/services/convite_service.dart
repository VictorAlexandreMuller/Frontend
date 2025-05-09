import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:festora/services/token_service.dart';

class ConviteService {
  final String baseUrl = 'http://localhost:8080/eventos/convites';

  Future<void> enviarConvites(String eventoId, List<String> usuariosIds) async {
    final token = await TokenService.obterToken();

    final response = await http.post(
      Uri.parse('$baseUrl/$eventoId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(usuariosIds),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao enviar convites');
    }
  }

  Future<List<Map<String, dynamic>>> listarConvitesUsuario() async {
    final token = await TokenService.obterToken();

    final response = await http.get(
      Uri.parse('$baseUrl/usuario'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao listar convites recebidos');
    }
  }
}
