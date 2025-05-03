import 'package:festora/models/evento_details_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:festora/services/token_service.dart';

class PresenteEventoPage extends StatefulWidget {
  final EventoDetails evento;

  const PresenteEventoPage({super.key, required this.evento});

  static const String routeName = 'presente-evento';
  static const String routePath = '/presente-evento';

  @override
  State<PresenteEventoPage> createState() => _PresenteEventoPageState();
}

class _PresenteEventoPageState extends State<PresenteEventoPage> {
  final TextEditingController _nomeController = TextEditingController();
  bool _carregando = false;

  Future<void> _cadastrarPresente() async {

  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Cadastrar Presente'),
      backgroundColor: Colors.pinkAccent,
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome do presente',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.card_giftcard),
            label: const Text('Cadastrar'),
            onPressed: _carregando ? null : _cadastrarPresente,
          ),
          const SizedBox(height: 30),
          const Text(
            'Presentes já cadastrados:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
  child: widget.evento.presentes.isEmpty
    ? const Text('Nenhum presente cadastrado.')
    : ListView.builder(
        itemCount: widget.evento.presentes.length,
        itemBuilder: (context, index) {
          final presente = widget.evento.presentes[index];
          return Card(
  child: ExpansionTile(
    title: Row(
      children: [
        Expanded(child: Text(presente.titulo)),
        if (presente.responsaveis.isNotEmpty)
          const Icon(Icons.check_circle, color: Colors.green),
      ],
    ),
    subtitle: Text(presente.descricao),
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
        child: Text(
          'Quem vai entregar:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      if (presente.responsaveis.isEmpty)
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text('Ninguém se responsabilizou ainda.'),
        )
      else
        ...presente.responsaveis.map((r) => ListTile(
              leading: const Icon(Icons.person),
              title: Text(r.nome),
            )),
    ],
  ),
);
        },
      ),
)
        ],
      ),
    ),
  );
}

}
