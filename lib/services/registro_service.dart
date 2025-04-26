  import 'dart:convert';

import 'package:festora/config/api_config.dart';
import 'package:festora/models/RegistroErroModel.dart';
import 'package:festora/models/UsuarioRegisterModel';
import 'package:http/http.dart' as http;

class RegistroService {
  Future<(bool, RegistroErroModel)> criarUsuario(UsuarioRegisterModel usuario) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/usuarios/registrar');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario.toJson()),
    );



    if (response.statusCode == 200) {
      return (true, RegistroErroModel());
    } else {
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = jsonDecode(decodedBody);
      final errors = RegistroErroModel.fromJson(responseData);
      return (false, errors);
    }
  }
}