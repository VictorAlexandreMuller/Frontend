import 'package:festora/models/evento_details_model.dart';
import 'package:festora/services/convidado_service.dart';
import 'package:flutter/material.dart';

class ConvidadosPage extends StatefulWidget {
  final EventoDetails evento;

  const ConvidadosPage({super.key, required this.evento});

  static const String routeName = 'convidados';

  @override
  State<ConvidadosPage> createState() => _ConvidadosPageState();
}

class _ConvidadosPageState extends State<ConvidadosPage> {
  final TextEditingController _nomeController = TextEditingController();
  bool _isLoading = false;
  List<String> _convidados = []; // apenas nomes por enquanto
  bool _carregandoLista = true;

  Future<void> _carregarConvidados() async {
    setState(() => _carregandoLista = true);
    try {
      // Aqui você deve buscar os nomes dos convidados do backend
      // Por enquanto, vamos simular com dados fictícios:
      final lista =
          await ConvidadoService().buscarConvidados(widget.evento.id!);
      setState(() => _convidados = lista);
    } catch (_) {
      setState(() => _convidados = []);
    } finally {
      setState(() => _carregandoLista = false);
    }
  }

  Future<void> _adicionarConvidado() async {
    final nome = _nomeController.text.trim();
    if (nome.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      // Aqui você irá chamar o serviço que adiciona no banco (substituir por seu método real)
      await ConvidadoService().adicionarConvidado(nome, widget.evento.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Convidado adicionado com sucesso!')),
      );
      _nomeController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao adicionar convidado')),
      );
    } finally {
      await _carregarConvidados();
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarConvidados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convidados'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Convidado',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _adicionarConvidado,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Convidado'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFADD8E6), // azul bebê
                foregroundColor:
                    const Color.fromARGB(255, 0, 0, 0), // cor do texto e ícone
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _carregandoLista
                  ? const Center(child: CircularProgressIndicator())
                  : _convidados.isEmpty
                      ? const Center(
                          child: Text(
                            '📌 Nenhum convidado encontrado.',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _convidados.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(_convidados[index]),
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
