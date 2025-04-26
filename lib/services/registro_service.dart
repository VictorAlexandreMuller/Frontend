  import 'dart:convert';

import 'package:festora/config/api_config.dart';
import 'package:festora/models/UsuarioRegisterModel';
import 'package:http/http.dart' as http;

class RegistroService {
  Future<bool> criarUsuario(UsuarioRegisterModel usuario) async {
      final url = Uri.parse('${ApiConfig.baseUrl}/usuarios');

    final response = await http.post(
      Uri.parse('$url/registrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario.toJson()),
    );

  if (response.statusCode == 200) {
    return true;
  } 
  return false;
  }
  }