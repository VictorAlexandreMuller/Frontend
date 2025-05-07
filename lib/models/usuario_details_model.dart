import 'package:festora/models/evento_model.dart';
import 'package:festora/models/endereco_model.dart';

class UsuarioDetailsModel {
  final String id;
  final String nome;
  final String email;
  final String criadoEm;


  UsuarioDetailsModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.criadoEm

  });

  factory UsuarioDetailsModel.fromJson(Map<String, dynamic> json) {
    return UsuarioDetailsModel(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      criadoEm: json['criadoEm'],

    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'nome': nome,
      'email': email,
      'criadoEm': criadoEm
    };

    return data;
  }
}
