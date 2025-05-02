class Usuario {
  final String id;
  final String nome;

  Usuario({
    required this.id,
    required this.nome,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
    );
  }
}