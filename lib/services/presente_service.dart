import 'dart:convert';
import 'package:festora/models/presente_model.dart';
import 'package:festora/services/token_service.dart';
import 'package:http/http.dart' as http;

class PresenteService {
  final String baseUrl = 'http://localhost:8080/eventos/presentes';

  Future<List<PresenteModel>> listarPresentes(String eventoId) async {
    final response = await http.get(Uri.parse('$baseUrl/listar/$eventoId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => PresenteModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao listar presentes');
    }
  }

  Future<void> criarPresente(String eventoId, String nome) async {
    final token = await TokenService.obterToken();

    final response = await http.post(
      Uri.parse('$baseUrl/$eventoId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'nome': nome}),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar presente');
    }
  }

  Future<void> adicionarResponsavel(String presenteId) async {
    final response = await http.post(Uri.parse('$baseUrl/addResp/$presenteId'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar responsável');
    }
  }

  Future<void> removerResponsavel(String presenteId) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/removerResp/$presenteId'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao remover responsável');
    }
  }
}
