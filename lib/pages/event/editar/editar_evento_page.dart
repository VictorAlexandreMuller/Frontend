import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late TextEditingController _localController;
  late TextEditingController _estadoController;
  late TextEditingController _cidadeController;
  late TextEditingController _ruaController;
  late TextEditingController _numeroController;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.evento.titulo);
    _descricaoController = TextEditingController(text: widget.evento.descricao);
    _localController = TextEditingController(text: widget.evento.local);
    _estadoController = TextEditingController(text: widget.evento.estado);
    _cidadeController = TextEditingController(text: widget.evento.cidade);
    _ruaController = TextEditingController(text: widget.evento.rua);
    _numeroController =
        TextEditingController(text: widget.evento.numero?.toString() ?? '');

    final rawData = widget.evento.data ?? '';

    if (rawData.isNotEmpty) {
      try {
        // Corrige se vier com T ou espaços
        final parsedDate = DateTime.tryParse(rawData.replaceAll(' ', 'T'));
        if (parsedDate != null) {
          selectedDate = parsedDate;
          _dataController = TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(selectedDate!),
          );
        } else {
          selectedDate = null;
          _dataController = TextEditingController(text: '');
        }
      } catch (e) {
        selectedDate = null;
        _dataController = TextEditingController(text: '');
      }
    } else {
      selectedDate = null;
      _dataController = TextEditingController(text: '');
    }
  }

  String formatarDataOuVazio(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final parsed = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(parsed);
    } catch (_) {
      return '';
    }
  }

  void _inicializarCampos() {
    _tituloController = TextEditingController(text: widget.evento.titulo);
    _descricaoController = TextEditingController(text: widget.evento.descricao);
    _localController = TextEditingController(text: widget.evento.local);
    _estadoController = TextEditingController(text: widget.evento.estado);
    _cidadeController = TextEditingController(text: widget.evento.cidade);
    _ruaController = TextEditingController(text: widget.evento.rua);
    _numeroController =
        TextEditingController(text: widget.evento.numero?.toString() ?? '');

    selectedDate = _parseData(widget.evento.data ?? '');

    // Aqui o ajuste principal: garantir que o _dataController já esteja preenchido.
    _dataController = TextEditingController(
      text: selectedDate != null ? _formatarData(selectedDate!) : '',
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _dataController.dispose();
    _localController.dispose();
    _estadoController.dispose();
    _cidadeController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  String _formatarData(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  DateTime? _parseData(String input) {
    try {
      return DateTime.parse(input); // ISO 8601 vindo do banco/backend
    } catch (e) {
      return null;
    }
  }

  Future<void> _selecionarData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(190, 237, 245, 1),
            colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(190, 237, 245, 1)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dataController.text = _formatarData(picked);
      });
    }
  }

  Future<void> _salvarAlteracoes() async {
    if (_formKey.currentState?.validate() ?? false) {
      final eventoAtualizado = EventoModel(
        id: widget.evento.id,
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        tipo: widget.evento.tipo,
        data: selectedDate?.toIso8601String() ?? '',
        local: _localController.text,
        estado: _estadoController.text,
        cidade: _cidadeController.text,
        rua: _ruaController.text,
        numero: int.tryParse(_numeroController.text) ?? 0,
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

  Future<void> _refreshCampos() async {
    setState(() {
      _tituloController.clear();
      _descricaoController.clear();
      _localController.clear();
      _estadoController.clear();
      _cidadeController.clear();
      _ruaController.clear();
      _numeroController.clear();
      selectedDate = _parseData(widget.evento.data ?? '');
      _dataController.text =
          selectedDate != null ? _formatarData(selectedDate!) : '';

      // Repopula com o que veio originalmente
      _tituloController.text = widget.evento.titulo ?? '';
      _descricaoController.text = widget.evento.descricao ?? '';
      _localController.text = widget.evento.local ?? '';
      _estadoController.text = widget.evento.estado ?? '';
      _cidadeController.text = widget.evento.cidade ?? '';
      _ruaController.text = widget.evento.rua ?? '';
      _numeroController.text = widget.evento.numero?.toString() ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Evento'),
        backgroundColor: const Color.fromARGB(255, 152, 103, 236),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCampos,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Informe o título'
                      : null,
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
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Data',
                    suffixIcon: IconButton(
                      icon: const Icon(
                          Icons.calendar_today), // pode manter const aqui
                      onPressed: _selecionarData,
                    ),
                  ),
                  onTap: _selecionarData,
                  validator: (value) {
                    if (selectedDate == null) {
                      return 'Selecione uma data válida.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _localController,
                  decoration: const InputDecoration(labelText: 'Local'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _estadoController,
                  decoration: const InputDecoration(labelText: 'Estado'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cidadeController,
                  decoration: const InputDecoration(labelText: 'Cidade'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ruaController,
                  decoration: const InputDecoration(labelText: 'Rua'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numeroController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: const InputDecoration(labelText: 'Número'),
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
      ),
    );
  }
}
