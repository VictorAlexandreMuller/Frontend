import 'package:flutter/material.dart';
import 'package:festora/models/evento_model.dart';
import 'package:festora/services/evento_service.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class EditarEventoPage extends StatefulWidget {
  final EventoModel evento;

  const EditarEventoPage({super.key, required this.evento});

  static const String name = 'EditarEventoPage';

  @override
  State<EditarEventoPage> createState() => _EditarEventoPageState();
}

class _EditarEventoPageState extends State<EditarEventoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  late TextEditingController _dataController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.evento.titulo);
    _descricaoController = TextEditingController(text: widget.evento.descricao);
    _dataController =
        TextEditingController(text: _formatarData(widget.evento.data));
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  String _formatarData(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('yyyy-MM-dd HH:mm').format(date);
    } catch (e) {
      return isoDate;
    }
  }

  DateTime _parseData(String input) {
    return DateFormat('yyyy-MM-dd HH:mm').parse(input);
  }

  Future<void> _salvarAlteracoes() async {
    if (_formKey.currentState?.validate() ?? false) {
      final eventoAtualizado = EventoModel(
        id: widget.evento.id,
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        tipo: widget.evento.tipo,
        data: _parseData(_dataController.text).toIso8601String(),
        local: widget.evento.local,
        estado: widget.evento.estado,
        cidade: widget.evento.cidade,
        rua: widget.evento.rua,
        numero: widget.evento.numero,
      );

      try {
        final sucesso = await EventoService().editarEvento(eventoAtualizado);

        if (sucesso && mounted) {
          context.pop('evento_editado');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao editar evento')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Evento'),
        backgroundColor: const Color.fromARGB(255, 152, 103, 236),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o título' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a descrição'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dataController,
                decoration:
                    const InputDecoration(labelText: 'Data (yyyy-MM-dd HH:mm)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe a data';
                  try {
                    _parseData(value);
                    return null;
                  } catch (e) {
                    return 'Formato inválido';
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvarAlteracoes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 152, 103, 236),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
