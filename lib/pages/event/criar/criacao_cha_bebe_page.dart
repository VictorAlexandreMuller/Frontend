import 'package:festora/models/evento_model.dart';
import 'package:festora/services/evento_service.dart';
import 'package:flutter/material.dart';

class CriarChaBebePage extends StatefulWidget {
  const CriarChaBebePage({super.key});
  static const String routeName = '/criar-cha-bebe';

  @override
  State<CriarChaBebePage> createState() => _CriarChaBebePageState();
}

class _CriarChaBebePageState extends State<CriarChaBebePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController tipoController =
      TextEditingController(text: 'Chá de Bebê');
  final TextEditingController dataController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Chá de Bebê"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                  controller: tituloController,
                  decoration: const InputDecoration(labelText: 'Título')),
              TextFormField(
                  controller: descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição')),
              TextFormField(
                  controller: tipoController,
                  enabled: false,
                  decoration: const InputDecoration(labelText: 'Tipo')),
              TextFormField(
                controller: dataController,
                decoration: const InputDecoration(labelText: 'Data'),
                readOnly: true,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    dataController.text = picked.toIso8601String();
                  }
                },
              ),
              TextFormField(
                  controller: localController,
                  decoration: const InputDecoration(labelText: 'Local')),
              TextFormField(
                  controller: estadoController,
                  decoration: const InputDecoration(labelText: 'Estado')),
              TextFormField(
                  controller: cidadeController,
                  decoration: const InputDecoration(labelText: 'Cidade')),
              TextFormField(
                  controller: ruaController,
                  decoration: const InputDecoration(labelText: 'Rua')),
              TextFormField(
                  controller: numeroController,
                  decoration: const InputDecoration(labelText: 'Número'),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final evento = EventoModel(
                      titulo: tituloController.text,
                      descricao: descricaoController.text,
                      tipo: tipoController.text,
                      data: dataController.text,
                      local: localController.text,
                      estado: estadoController.text,
                      cidade: cidadeController.text,
                      rua: ruaController.text,
                      numero: int.tryParse(numeroController.text) ?? 0,
                    );

                    final sucesso = await EventoService().criarEvento(evento);

                    if (sucesso) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Evento criado com sucesso!')),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Erro ao criar evento')),
                      );
                    }
                  }
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
