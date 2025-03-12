import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final class FestoraAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FestoraAppBar(this.user, {super.key});

  final String user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFDCB98E),
      elevation: 4,
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Olá, $user!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.black, size: 30),
            onSelected: (String result) {
              if (result == 'config') {
              } else if (result == 'logout') {
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'config',
                child: Text('Configurações'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Sair'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
