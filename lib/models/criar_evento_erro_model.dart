class EventoErroModel {
  final String titulo;
  final String descricao;
  final String tipo;
  final String data;
  final String local;
  final String estado;
  final String cidade;
  final String rua;
  final String numero;

  EventoErroModel({
    this.titulo = '',
    this.descricao = '',
    this.tipo = '',
    this.data = '',
    this.local = '',
    this.estado = '',
    this.cidade = '',
    this.rua = '',
    this.numero = '',
  });

  factory EventoErroModel.fromJson(Map<String, dynamic> json) {
    return EventoErroModel(
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      tipo: json['tipo'] ?? '',
      data: json['data'] ?? '',
      local: json['local'] ?? '',
      estado: json['estado'] ?? '',
      cidade: json['cidade'] ?? '',
      rua: json['rua'] ?? '',
      numero: json['numero'] ?? '',
    );
  }

    bool temErros() {
  return titulo.isNotEmpty ||
      descricao.isNotEmpty ||
      tipo.isNotEmpty ||
      data.isNotEmpty ||
      local.isNotEmpty ||
      estado.isNotEmpty ||
      cidade.isNotEmpty ||
      rua.isNotEmpty ||
      numero.isNotEmpty;
}
}
