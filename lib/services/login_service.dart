import 'dart:convert';

import 'package:festora/config/api_config.dart';
import 'package:festora/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<bool> fazerLogin(LoginModel login) async {
    final url = Uri.parse(
        '${ApiConfig.baseUrl}/usuarios/login'); // exemplo: http://localhost:8080/api/eventos
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(login.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      return true;
    }
    if (response.statusCode == 403) {
      return false;
    } else {
      return false;
    }
  }
}
