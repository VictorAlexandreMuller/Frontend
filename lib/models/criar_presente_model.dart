class PresenteCreateModel {
  final String titulo;
  final String descricao;

  PresenteCreateModel({required this.titulo, required this.descricao});

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
    };
  }
}
