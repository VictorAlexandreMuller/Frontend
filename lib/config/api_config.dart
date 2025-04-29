import 'package:flutter/foundation.dart';

class ApiConfig {
  static final String baseUrl = kIsWeb
      ? 'http://localhost:8080' // para web
      // : 'http://192.168.15.75:8080'; // LEIA-ME para emulador Android especificamente no celular do VICTOR PC
      : 'http://192.168.5.123:8080'; // LEIA-ME para emulador Android especificamente no celular do VICTOR NOTEBOOK
  // : '<ipv4 do pc>:8080'; // LEIA-ME para emulador Android de voce que está lendo e quer fazer rodar no seu celular... comente a linha 6 e coloque o ip da sua maquina aqui
}
