import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final Function(int) onItemSelected;
  final int currentIndex;
  final VoidCallback? onCreatePressed;

  const CustomBottomNavigation({
    super.key,
    required this.onItemSelected,
    required this.currentIndex,
    this.onCreatePressed,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // roda para sempre
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIcon(IconData icon, int index) {
    final bool isSelected = widget.currentIndex == index;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final gradient = LinearGradient(
          colors: const [Color(0xFF47CFE3), Color(0xFFF279A4)],
          begin: Alignment(-1 + _controller.value * 2, 0),
          end: Alignment(1 - _controller.value * 2, 0),
        );

        final iconWidget = Icon(
          icon,
          size: 22,
          color: isSelected ? Colors.white : Colors.black,
        );

        return Center(
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: isSelected
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF3B3B3B)
                          .withOpacity(0.3), // ✅ 60% de opacidade

                      width: 2,
                    ),
                  )
                : null,
            child: isSelected
                ? ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: const [
                          Color(0xFF47CFE3), // azul
                          Color(0xFFF279A4), // rosa
                          Color(0xFF47CFE3), // azul de novo pra looping
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.mirror,
                        stops: const [0.0, 0.5, 1.0],
                        transform: GradientRotation(0), // fixo
                      ).createShader(
                        Rect.fromLTWH(
                          -bounds.width +
                              (_controller.value *
                                  bounds.width *
                                  2), // move linearmente
                          0,
                          bounds.width * 2,
                          bounds.height,
                        ),
                      );
                    },
                    child: iconWidget,
                  )
                : iconWidget,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFFF3F3F3),
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            offset: Offset(0, -2),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          if (index == 2 && widget.onCreatePressed != null) {
            widget.onCreatePressed!(); // 🔥 chama o popup
          } else {
            widget.onItemSelected(index);
          }
        },
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white, // tratado no ShaderMask
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.search, 1),
            label: "Buscar",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.add_circle_outline, 2), // novo botão central
            label: "Criar",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.list_alt, 3), // botão de listagem
            label: "Listagem",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 4),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
