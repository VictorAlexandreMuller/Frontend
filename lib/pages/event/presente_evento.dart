import 'package:festora/models/criar_presente_model.dart';
import 'package:festora/models/evento_details_model.dart';
import 'package:festora/services/evento_service.dart';
import 'package:festora/services/presente_service.dart';
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
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  bool _carregando = false;
  late EventoDetails _evento;

  @override
  void initState() {
    super.initState();
    _evento = widget.evento;
  }

  Future<void> _cadastrarPresente(String eventoId) async {
    final presente = PresenteCreateModel(
        titulo: _tituloController.text, descricao: _descricaoController.text);

    setState(() {
      _carregando = true;
    });

    try {
      bool sucesso = await PresenteService().criarPresente(eventoId, presente);

      if (sucesso) {
        // Recarrega o evento após o cadastro do presente
        await carregarEvento();
        // Exibe uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Presente cadastrado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao cadastrar presente.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  Future<void> carregarEvento() async {
    setState(() {
      _carregando = true;
    });

    try {
      final (sucesso, evento) = await EventoService().buscarEvento(_evento.id);
      if (sucesso) {
        setState(() {
          _evento = evento;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao carregar evento.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  void _abrirModalCadastro() {
    _tituloController.clear();
    _descricaoController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo Presente'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Adicionar'),
            onPressed: _carregando
                ? null
                : () async {
                    await _cadastrarPresente(_evento.id);
                    Navigator.of(context)
                        .pop(); // Fecha o modal após o cadastro
                  },
          ),
        ],
      ),
    );
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
              onPressed: _carregando ? null : _abrirModalCadastro,
            ),
            const SizedBox(height: 30),
            const Text(
              'Presentes já cadastrados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _evento.presentes
                      .isEmpty // Usando _evento para acessar os presentes
                  ? const Text('Nenhum presente cadastrado.')
                  : ListView.builder(
                      itemCount: _evento
                          .presentes.length, // Usando _evento aqui também
                      itemBuilder: (context, index) {
                        final presente =
                            _evento.presentes[index]; // Usando _evento
                        return Card(
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                Expanded(child: Text(presente.titulo)),
                                if (presente.responsaveis.isNotEmpty)
                                  const Icon(Icons.check_circle,
                                      color: Colors.green),
                              ],
                            ),
                            subtitle: Text(presente.descricao),
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, bottom: 8.0),
                                child: Text(
                                  'Quem vai entregar:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (presente.responsaveis.isEmpty)
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.0, bottom: 8.0),
                                  child:
                                      Text('Ninguém se responsabilizou ainda.'),
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
