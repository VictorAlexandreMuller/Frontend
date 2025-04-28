import 'package:flutter/material.dart';

class SelectTipoChaDialog extends StatelessWidget {
  const SelectTipoChaDialog({super.key});

  static Future<String?> show(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return const SelectTipoChaDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Qual tipo de chá deseja criar?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop('Chá de Bebê'); // <-- retorna texto
            },
            icon: const Icon(Icons.child_care),
            label: const Text("Chá de Bebê"),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop('Chá Revelação');
            },
            icon: const Icon(Icons.cake),
            label: const Text("Chá Revelação"),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop('Chá de Fraldas');
            },
            icon: const Icon(Icons.baby_changing_station),
            label: const Text("Chá de Fraldas"),
          ),
        ],
      ),
    );
  }
}
