import 'dart:convert';
import 'package:festora/config/api_config.dart';
import 'package:festora/models/usuario_details_model.dart';
import 'package:festora/utils/TokenHelper.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  final url = Uri.parse('${ApiConfig.baseUrl}/usuarios');

  Future<UsuarioDetailsModel> obterUsuario() async {
    String? token = await TokenHelper.getToken();

    final response = await http.get(
      Uri.parse('$url/find'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonMap = jsonDecode(decodedBody);
      return UsuarioDetailsModel.fromJson(jsonMap);
    } else {
      throw Exception('Falha ao carregar usuário ativo');
    }
  }

  Future<bool> isParticipando(String eventoId) async {
    try {
      String? token = await TokenHelper.getToken();
      final response = await http.get(
        Uri.parse('$url/isParticipando/$eventoId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        throw Exception("Erro ao verificar participação");
      }
    } catch (e) {
      throw Exception("Erro ao verificar participação: $e");
    }
  }
}
