class ConvidadoModel {
  final String id;
  final String nome;
  final String eventoId;

  ConvidadoModel({
    required this.id,
    required this.nome,
    required this.eventoId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'eventoId': eventoId,
      };

  factory ConvidadoModel.fromJson(Map<String, dynamic> json) {
    return ConvidadoModel(
      id: json['id'],
      nome: json['nome'],
      eventoId: json['eventoId'],
    );
  }
}
