import 'package:flutter/foundation.dart';

class ApiConfig {
  static final String baseUrl = kIsWeb
      ? 'http://localhost:8080' // para web
      : 'http://10.0.2.2:8080'; // para emulador Android
}