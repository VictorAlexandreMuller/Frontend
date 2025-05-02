class RegistroErroModel {
  final String nome;
  final String email;
  final String senha;
  final String senhaRepitida;

  RegistroErroModel({
    this.nome = '',
    this.email = '',
    this.senha = '',
    this.senhaRepitida = '',
  });

  factory RegistroErroModel.fromJson(Map<String, dynamic> json) {
    return RegistroErroModel(
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      senha: json['senha'] ?? '',
      senhaRepitida: json['senhaRepitida'] ?? '',
    );
  }
}