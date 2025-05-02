import 'package:festora/models/usuario_response_model.dart';

class Presente {
  final String id;
  final String titulo;
  final String descricao;
  final List<Usuario> responsaveis;

  Presente({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.responsaveis,
  });

  factory Presente.fromJson(Map<String, dynamic> json) {
    return Presente(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      responsaveis: (json['responsaveis'] as List)
          .map((e) => Usuario.fromJson(e))
          .toList(),
    );
  }
}