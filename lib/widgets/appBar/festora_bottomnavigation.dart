import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final Function(int) onItemSelected;
  final int currentIndex;

  const CustomBottomNavigation({
    super.key,
    required this.onItemSelected,
    required this.currentIndex,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onItemSelected,
        backgroundColor: const Color(0xFFDCB98E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Buscar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
