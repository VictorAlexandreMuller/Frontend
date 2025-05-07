import 'package:festora/models/criar_presente_model.dart';
import 'package:festora/models/evento_details_model.dart';
import 'package:festora/models/presente_model.dart';
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

  late List<PresenteModel> presentes = [];

  @override
  void initState() {
    super.initState();
    _evento = widget.evento;
    carregarPresentes();
  }

  Future<void> _excluirPresente(String presenteId) async {
    setState(() {
      _carregando = true;
    });

    try {
      bool sucesso = await PresenteService().removerPresente(presenteId);

      if (sucesso) {
        // Recarrega o evento após associar o responsável
        await carregarPresentes();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entrega cancelada com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao cancelar entrega.')),
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

  Future<void> cancelarEntrega(String presenteId) async {
    setState(() {
      _carregando = true;
    });

    try {
      (bool, PresenteModel) response = await PresenteService().removerResponsavel(presenteId);

      if (response.$1) {
        setState(() {
          final index = presentes.indexWhere((p) => p.id == response.$2.id);
          if (index != -1) {
            presentes[index] = response.$2;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entrega cancelada com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao cancelar entrega.')),
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

  Future<void> _adicionarResponsavel(String presenteId) async {
    setState(() {
      _carregando = true;
    });

    try {
      (bool, PresenteModel) sucesso =
          await PresenteService().adicionarResponsavel(presenteId);

      if (sucesso.$1) {
        setState(() {
          final index = presentes.indexWhere((p) => p.id == sucesso.$2.id);
          if (index != -1) {
            presentes[index] = sucesso.$2;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Responsável adicionado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao adicionar responsável.')),
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

  Future<void> _cadastrarPresente(String eventoId) async {
    final presente = PresenteCreateModel(
        titulo: _tituloController.text, descricao: _descricaoController.text);
    setState(() {
      _carregando = true;
    });
    try {
      (bool, PresenteModel) response =
          await PresenteService().criarPresente(eventoId, presente);
      if (response.$1) {
        setState(() {
          presentes.add(response.$2);
        });
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

  Future<void> carregarPresentes() async {
    setState(() {
      _carregando = true;
    });

    try {
      final presentes = await PresenteService().buscarPresentes(_evento.id);
      setState(() {
        this.presentes = presentes;
      });
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

  void _abrirModalEditar(presente) {
    _tituloController.text = presente.titulo;
    _descricaoController.text = presente.descricao;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Presente'),
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
            child: const Text('Salvar'),
            onPressed: _carregando
                ? null
                : () async {
                    await PresenteService().editarPresente(
                      presente.id,
                      PresenteCreateModel(
                        titulo: _tituloController.text,
                        descricao: _descricaoController.text,
                      ),
                    );
                    carregarPresentes();
                    Navigator.of(context).pop();
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
        title: const Text('Presentes'),
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
            if (_evento.isAutor)
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
              child: presentes.isEmpty
                  ? const Text('Nenhum presente cadastrado.')
                  : ListView.builder(
                      itemCount: presentes.length,
                      itemBuilder: (context, index) {
                        final presente = presentes[index];
                        return Card(
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Título e descrição à esquerda
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        presente.titulo,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        presente.descricao,
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Row(
                                  children: [
                                    if (_evento.isAutor) ...[
                                      // Botão Editar
                                      ElevatedButton(
                                        onPressed: _carregando
                                            ? null
                                            : () {
                                                // Aqui você pode abrir um modal para editar o presente
                                                _abrirModalEditar(presente);
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orangeAccent,
                                        ),
                                        child: const Text('Editar'),
                                      ),
                                      const SizedBox(width: 5),
                                      // Botão Excluir
                                      ElevatedButton(
                                        onPressed: _carregando
                                            ? null
                                            : () {
                                                _excluirPresente(presente.id);
                                              },
                                        child: const Text('Excluir'),
                                      ),
                                    ],
                                    const SizedBox(width: 5),
                                    // Botão Entregar/Cancelar
                                    ElevatedButton(
                                      onPressed: _carregando
                                          ? null
                                          : () {
                                              if (presente.isResponsavel) {
                                                // Chama a função para cancelar a entrega
                                                cancelarEntrega(presente.id);
                                              } else {
                                                // Chama a função para adicionar um responsável
                                                _adicionarResponsavel(
                                                    presente.id);
                                              }
                                            },
                                      child: Text(presente.isResponsavel
                                          ? 'Cancelar'
                                          : 'Entregar'),
                                    ),
                                    const SizedBox(width: 5),
                                    // Coloca um SizedBox com largura fixa para reservar espaço para o ícone
                                    SizedBox(
                                      width:
                                          24, // Largura do ícone de check (ajustável)
                                      child: presente.responsaveis.isNotEmpty
                                          ? const Icon(Icons.check_circle,
                                              color: Colors.pinkAccent)
                                          : null,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
