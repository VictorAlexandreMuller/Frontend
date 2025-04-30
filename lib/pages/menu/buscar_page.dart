import 'package:flutter/material.dart';

class BuscarPage extends StatefulWidget {
  static const String name = 'buscar';

  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  final TextEditingController _searchController = TextEditingController();
  String _termoBuscado = '';

  void _buscar(String termo) {
    setState(() {
      _termoBuscado = termo;
    });

    // TODO: Adicione a lógica de busca aqui futuramente
    print('Buscando por: $termo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Buscar'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onSubmitted: _buscar,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _buscar('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_termoBuscado.isNotEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Resultados para "$_termoBuscado"',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text(
                    'Digite algo para buscar',
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
