import 'package:flutter/material.dart';
import 'package:festora/models/evento_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:festora/services/token_service.dart';

class PresenteEventoPage extends StatefulWidget {
  final EventoModel evento;

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
    final nome = _nomeController.text.trim();
    if (nome.isEmpty) return;

    setState(() => _carregando = true);

    try {
      final token = await TokenService.obterToken();

      final response = await http.post(
        Uri.parse(
            'http://localhost:8080/eventos/presentes/${widget.evento.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"nome": nome}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Presente cadastrado com sucesso!')),
        );
        _nomeController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar presente.')),
      );
    }

    setState(() => _carregando = false);
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
          ],
        ),
      ),
    );
  }
}
