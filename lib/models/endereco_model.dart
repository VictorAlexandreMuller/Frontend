class EnderecoModel {
  final String id;
  final String local;
  final String estado;
  final String cidade;
  final String rua;
  final int numero;

  EnderecoModel({
    required this.id,
    required this.local,
    required this.estado,
    required this.cidade,
    required this.rua,
    required this.numero,
  });

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      id: json['id'],
      local: json['local'],
      estado: json['estado'],
      cidade: json['cidade'],
      rua: json['rua'],
      numero: json['numero'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'local': local,
      'estado': estado,
      'cidade': cidade,
      'rua': rua,
      'numero': numero,
    };
  }
}
