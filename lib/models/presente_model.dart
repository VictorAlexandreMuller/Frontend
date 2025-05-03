import 'package:festora/models/usuario_response_model.dart';

class PresenteModel {
  final String id;
  final String titulo;
  final String descricao;
  final List<Usuario> responsaveis;

  PresenteModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.responsaveis,
  });

  factory PresenteModel.fromJson(Map<String, dynamic> json) {
    return PresenteModel(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['titulo'],
      responsaveis: (json['responsaveis'] as List)
          .map((e) => Usuario.fromJson(e))
          .toList(),
    );
  }
}
