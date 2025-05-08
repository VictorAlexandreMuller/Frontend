import 'dart:convert';
import 'package:festora/config/api_config.dart';
import 'package:http/http.dart' as http;

class ConvidadoService {
  final String baseUrl = '${ApiConfig.baseUrl}/eventos/convidados'; // ajuste se necessário

  Future<void> adicionarConvidado(String nome, String eventoId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nome,
        'eventoId': eventoId,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao adicionar convidado');
    }
  }

  Future<List<String>> buscarConvidados(String eventoId) async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      final List<dynamic> dados = jsonDecode(response.body);
      return dados.map<String>((item) => item['nome'] as String).toList();
    } else {
      throw Exception('Erro ao buscar convidados');
    }
  }
}
