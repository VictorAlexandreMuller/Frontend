import 'package:flutter/material.dart';
import 'package:festora/models/evento_model.dart';
import 'package:festora/services/evento_service.dart';
import 'package:go_router/go_router.dart';
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

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                          'detalhes-evento',
                          extra: evento,
                        );
                      },
                      child: Card(
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
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    label: const Text('Editar'),
                                    onPressed: () async {
                                      final result =
                                          await context.pushNamed<String>(
                                        'criar-evento',
                                        extra: evento,
                                      );
                                      if (result == 'evento_editado') {
                                        await carregarEventos();
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Evento atualizado com sucesso!')),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    label: const Text('Excluir'),
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  const Text('Excluir Evento'),
                                              content: const Text(
                                                  'Tem certeza que deseja excluir este evento?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: const Text('Cancelar'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red),
                                                  child: const Text('Excluir'),
                                                ),
                                              ],
                                            ),
                                          ) ??
                                          false;

                                      if (confirm) {
                                        final sucesso = await EventoService()
                                            .desativarEvento(evento.id!);
                                        if (sucesso) {
                                          await carregarEventos();
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Evento excluído com sucesso.'),
                                              ),
                                            );
                                          }
                                        } else {
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Erro ao excluir evento.'),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
    );
  }
}
