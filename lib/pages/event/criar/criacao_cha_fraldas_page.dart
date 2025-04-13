import 'package:flutter/material.dart';

class CriarChaFraldasPage extends StatefulWidget {
  const CriarChaFraldasPage({super.key});
  static const String routeName = '/criar-cha-fraldas';

  @override
  State<CriarChaFraldasPage> createState() => _CriarChaFraldasPageState();
}

class _CriarChaFraldasPageState extends State<CriarChaFraldasPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController tipoController = TextEditingController(text: 'Chá de Fraldas');
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
        title: const Text("Criar Chá de Fraldas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: tituloController, decoration: const InputDecoration(labelText: 'Título')),
              TextFormField(controller: descricaoController, decoration: const InputDecoration(labelText: 'Descrição')),
              TextFormField(controller: tipoController, enabled: false, decoration: const InputDecoration(labelText: 'Tipo')),
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
              TextFormField(controller: localController, decoration: const InputDecoration(labelText: 'Local')),
              TextFormField(controller: estadoController, decoration: const InputDecoration(labelText: 'Estado')),
              TextFormField(controller: cidadeController, decoration: const InputDecoration(labelText: 'Cidade')),
              TextFormField(controller: ruaController, decoration: const InputDecoration(labelText: 'Rua')),
              TextFormField(
                controller: numeroController,
                decoration: const InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print({
                      "titulo": tituloController.text,
                      "descricao": descricaoController.text,
                      "tipo": tipoController.text,
                      "data": dataController.text,
                      "local": localController.text,
                      "estado": estadoController.text,
                      "cidade": cidadeController.text,
                      "rua": ruaController.text,
                      "numero": int.tryParse(numeroController.text),
                    });
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
