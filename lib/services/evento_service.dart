import 'dart:convert';
import 'package:festora/models/criar_evento_erro_model.dart';
import 'package:festora/models/evento_model.dart';
import 'package:http/http.dart' as http;
import 'package:festora/utils/TokenHelper.dart';
import 'package:festora/config/api_config.dart';

class EventoService {
  Future<(bool, EventoErroModel)> criarEvento(EventoModel evento) async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(evento.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return (true, EventoErroModel());
      } else if (response.statusCode == 400) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> responseData = jsonDecode(decodedBody);
        final errors = EventoErroModel.fromJson(responseData);
        return (false, errors);
      } else {
        return (false, EventoErroModel());
      }
    } catch (e) {
      print('Erro na comunicação: $e');
      return (false, EventoErroModel());
    }
  }

  Future<List<EventoModel>> listarEventosAtivos() async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/ativos'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
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

  Future<bool> desativarEvento(String id) async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/$id/desativar'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Erro na comunicação: $e');
      return false;
    }
  }

  Future<(bool, EventoErroModel)> editarEvento(EventoModel evento) async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/${evento.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(evento.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return (true, EventoErroModel());
      } else if (response.statusCode == 400) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> responseData = jsonDecode(decodedBody);
        final errors = EventoErroModel.fromJson(responseData);
        return (false, errors);
      } else {
        return (false, EventoErroModel());
      }
    } catch (e) {
      print('Erro na comunicação: $e');
      return (false, EventoErroModel());
    }
  }

  Future<bool> verificarSeUsuarioEhAutor(String eventoId) async {
    final token = await TokenHelper.getToken();
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/$eventoId/verificar-autor'),
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
