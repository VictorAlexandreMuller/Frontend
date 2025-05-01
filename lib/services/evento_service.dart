import 'dart:convert';
import 'package:flutter/foundation.dart'; // <-- para usar kIsWeb
import 'package:festora/models/evento_model.dart';
import 'package:http/http.dart' as http;
import 'package:festora/utils/TokenHelper.dart';

class EventoService {
  static final String baseUrl = kIsWeb
      ? 'http://localhost:8080/eventos' // navegador web (teste local)
      : 'http://192.168.71.222:8080/eventos'; // seu IP real da máquina, usado pelo celular VICTOR PC
  // : 'http://192.168.71.222:8080/eventos'; // seu IP real da máquina, usado pelo celular VICTOR NOTEBOOK

  Future<bool> criarEvento(EventoModel evento) async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(evento.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print('Erro ao criar evento: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Erro na comunicação: $e');
      return false;
    }
  }

  Future<List<EventoModel>> listarEventosAtivos() async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ativos'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(
            utf8.decode(response.bodyBytes)); // utf8.decode para segurança
        return data.map((e) => EventoModel.fromJson(e)).toList();
      } else {
        print('Erro ao listar eventos: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erro na comunicação: $e');
      return [];
    }
  }

  Future<void> desativarEvento(String id) async {
    final token = await TokenHelper.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/$id/desativar'), // <- endpoint novo
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao desativar o evento');
    }
  }

  Future<bool> editarEvento(EventoModel evento) async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.put(
        Uri.parse('${baseUrl}/${evento.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(evento.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 403) {
        throw Exception('Você não tem permissão para editar este evento.');
      } else {
        print('Erro ao editar evento: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Erro na comunicação: $e');
      rethrow;
    }
  }

  Future<bool> verificarSeUsuarioEhAutor(String eventoId) async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.get(
        Uri.parse('${EventoService.baseUrl}/$eventoId/verificar-autor'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response.body.toLowerCase() == 'true';
      } else {
        print('Erro ao verificar autor: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Erro na comunicação: $e');
      return false;
    }
  }
}
