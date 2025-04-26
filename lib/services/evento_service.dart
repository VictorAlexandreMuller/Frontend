import 'dart:convert';
import '../models/evento_model.dart';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;

class EventoService {
  final url = Uri.parse('${ApiConfig.baseUrl}/eventos');

  Future<bool> criarEvento(EventoModel evento) async {
    final response = await http.post(
      Uri.parse('$url'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(evento.toJson()),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<List<EventoModel>> listarEventosAtivos(token) async {
    final response = await http.get(
      Uri.parse('$url/ativos'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
    final decodedBody = utf8.decode(response.bodyBytes);
    final List<dynamic> data = jsonDecode(decodedBody);
    return data.map((e) => EventoModel.fromJson(e)).toList();
  } else {
    throw Exception('Falha ao carregar eventos ativos');
  }
  }
}
