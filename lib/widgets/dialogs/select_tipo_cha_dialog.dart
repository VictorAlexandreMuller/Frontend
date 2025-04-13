import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectTipoChaDialog extends StatelessWidget {
  const SelectTipoChaDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const SelectTipoChaDialog(),
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
              Navigator.pop(context);
              context.go('/criar-cha-bebe');
            },
            icon: const Icon(Icons.child_care),
            label: const Text("Chá de Bebê"),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              context.go('/criar-cha-revelacao');
            },
            icon: const Icon(Icons.cake),
            label: const Text("Chá Revelação"),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              context.go('/criar-cha-fraldas');
            },
            icon: const Icon(Icons.baby_changing_station),
            label: const Text("Chá de Fraldas"),
          ),
        ],
      ),
    );
  }
}
