import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final String baseUrl =
      kIsWeb ? 'http://localhost:8080' : dotenv.env['BACK_URL'] ?? '';
  //   : 'http://192.168.15.75:8080'; // victor pc
  // : 'http://192.168.160.222:8080'; // victor notebook
}
