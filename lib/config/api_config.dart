import 'package:flutter/foundation.dart';

class ApiConfig {
  static final String baseUrl = kIsWeb
      ? 'http://localhost:8080' // web
         : 'http://192.168.15.75:8080'; // victor pc
      // : 'http://192.168.71.222:8080'; // victor notebook
}
