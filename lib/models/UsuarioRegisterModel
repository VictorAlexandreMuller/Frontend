class UsuarioRegisterModel {
  final String nome;
  final String email;
  final String password;
  final String repeatPassword;

  UsuarioRegisterModel({
    required this.nome,
    required this.email,
    required this.password,
    required this.repeatPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'senha': password,
      'senhaRepitida': repeatPassword,
    };
  }
}
