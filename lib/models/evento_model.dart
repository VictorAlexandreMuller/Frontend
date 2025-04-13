class EventoModel {
  final String titulo;
  final String descricao;
  final String tipo;
  final String data;
  final String local;
  final String estado;
  final String cidade;
  final String rua;
  final int numero;

  EventoModel({
    required this.titulo,
    required this.descricao,
    required this.tipo,
    required this.data,
    required this.local,
    required this.estado,
    required this.cidade,
    required this.rua,
    required this.numero,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'tipo': tipo,
      'data': data,
      'local': local,
      'estado': estado,
      'cidade': cidade,
      'rua': rua,
      'numero': numero,
    };
  }
}
