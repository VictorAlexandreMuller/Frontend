import 'dart:convert';
import '../models/evento_model.dart';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;

class EventoService {
  Future<bool> criarEvento(EventoModel evento) async {
    final url = Uri.parse(
        '${ApiConfig.baseUrl}/eventos'); // exemplo: http://localhost:8080/api/eventos
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/eventos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(evento.toJson()),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }
}
