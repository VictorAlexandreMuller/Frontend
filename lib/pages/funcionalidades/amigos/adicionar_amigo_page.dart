import 'package:flutter/material.dart';
import 'package:festora/services/amizade_service.dart';

class AdicionarAmigoPage extends StatefulWidget {
  const AdicionarAmigoPage({super.key});
  static const String routeName = 'adicionar-amigo';

  @override
  State<AdicionarAmigoPage> createState() => _AdicionarAmigoPageState();
}

class _AdicionarAmigoPageState extends State<AdicionarAmigoPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _enviarSolicitacao() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await AmizadeService().enviarSolicitacao(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitação enviada!')),
      );
      _emailController.clear();
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar solicitação')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Amigo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail do Amigo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _enviarSolicitacao,
              child: const Text('Enviar Solicitação'),
            ),
          ],
        ),
      ),
    );
  }
}
