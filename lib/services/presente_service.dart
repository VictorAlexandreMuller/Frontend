import 'dart:convert';
import 'package:festora/models/criar_presente_model.dart';
import 'package:festora/models/presente_model.dart';
import 'package:festora/services/token_service.dart';
import 'package:http/http.dart' as http;

class PresenteService {
  final String baseUrl = 'http://localhost:8080/eventos/presentes';

  Future<List<PresenteModel>> buscarPresentes(String eventoId) async {
    final token = await TokenService.obterToken();

    final response = await http.get(
      Uri.parse('$baseUrl/$eventoId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      return data.map((json) => PresenteModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao listar presentes');
    }
  }

  Future<(bool, PresenteModel)> criarPresente(
      String eventoId, PresenteCreateModel presente) async {
    final token = await TokenService.obterToken();

    final response = await http.post(
      Uri.parse('$baseUrl/$eventoId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(presente.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      return (true, PresenteModel.fromJson(data));
    } else {
      throw Exception('Erro ao listar presentes');
    }
  }

  Future<bool> editarPresente(
      String presenteId, PresenteCreateModel presente) async {
    final token = await TokenService.obterToken();

    final response = await http.put(
      Uri.parse('$baseUrl/$presenteId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(presente.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<(bool, PresenteModel)> adicionarResponsavel(String presenteId) async {
    final token = await TokenService.obterToken();

    final response = await http.post(
      Uri.parse('$baseUrl/addResp/$presenteId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return (true, PresenteModel.fromJson(data));
    } else {
      throw Exception('Erro ao listar presentes');
    }
  }

  Future<bool> removerResponsavel(String presenteId) async {
    final token = await TokenService.obterToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/removerResp/$presenteId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removerPresente(String presenteId) async {
    final token = await TokenService.obterToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/$presenteId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
