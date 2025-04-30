import 'package:flutter/material.dart';
import 'package:festora/models/evento_model.dart';
import 'package:festora/services/evento_service.dart';
import 'package:intl/intl.dart';

class ListagemPage extends StatefulWidget {
  static const String name = 'listagem';

  const ListagemPage({super.key});

  @override
  State<ListagemPage> createState() => ListagemPageState();
}

class ListagemPageState extends State<ListagemPage> {
  List<EventoModel> _eventos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    carregarEventos();
  }

  Future<void> carregarEventos() async {
    final eventos = await EventoService().listarEventosAtivos();
    setState(() {
      _eventos = eventos;
      _carregando = false;
    });
  }

  String _formatarData(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy HH:mm').format(date);
    } catch (_) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Eventos'),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: const Color(0xFFF3F3F3),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _eventos.isEmpty
              ? const Center(child: Text('Nenhum evento encontrado.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _eventos.length,
                  itemBuilder: (context, index) {
                    final evento = _eventos[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              evento.titulo ?? 'Sem título',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              evento.descricao ?? 'Sem descrição',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Data: ${_formatarData(evento.data)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
