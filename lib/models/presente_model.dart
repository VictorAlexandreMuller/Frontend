class PresenteModel {
  final String id;
  final String nome;
  final bool responsavel;

  PresenteModel({
    required this.id,
    required this.nome,
    required this.responsavel,
  });

  factory PresenteModel.fromJson(Map<String, dynamic> json) {
    return PresenteModel(
      id: json['id'],
      nome: json['nome'],
      responsavel: json['responsavel'] ?? false,
    );
  }
}
