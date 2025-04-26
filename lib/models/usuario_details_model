import 'package:festora/models/evento_model.dart';
import 'package:festora/models/endereco_model.dart';

class UsuarioDetailsModel {
  final String id;
  final String nome;
  final String email;
  final EnderecoModel? endereco;
  final List<EventoModel> eventosCriados;
  final List<EventoModel> eventosParticipados;

  UsuarioDetailsModel({
    required this.id,
    required this.nome,
    required this.email,
    this.endereco,
    required this.eventosCriados,
    required this.eventosParticipados,
  });

  factory UsuarioDetailsModel.fromJson(Map<String, dynamic> json) {
    return UsuarioDetailsModel(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      endereco: json['endereco'] != null
          ? EnderecoModel.fromJson(json['endereco'])
          : null,
      eventosCriados: (json['eventosCriados'] as List)
          .map((e) => EventoModel.fromJson(e))
          .toList(),
      eventosParticipados: (json['eventosParticipados'] as List)
          .map((e) => EventoModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'nome': nome,
      'email': email,
      'eventosCriados': eventosCriados.map((e) => e.toJson()).toList(),
      'eventosParticipados': eventosParticipados.map((e) => e.toJson()).toList(),
    };
    if (endereco != null) {
      data['endereco'] = endereco!.toJson();
    }
    return data;
  }
}
