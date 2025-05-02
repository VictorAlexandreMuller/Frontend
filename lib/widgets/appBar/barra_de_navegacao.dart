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
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIcon(IconData icon, int index) {
    final bool isSelected = widget.currentIndex == index;

    if (!isSelected) {
      return Icon(
        icon,
        size: 24,
        color: Colors.black87,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: const [
                Color(0xFF47CFE3),
                Color(0xFFF279A4),
                Color(0xFF47CFE3),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.mirror,
              transform: GradientRotation(_controller.value * 6.28),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.onCreatePressed?.call,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(
                      255, 174, 174, 174), // brilho suave da borda
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.black12, // sombra sutil por baixo
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Fundo com degradê animado
                ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: const [
                        Color(0xFF47CFE3),
                        Color(0xFFF279A4),
                        Color(0xFF47CFE3),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      tileMode: TileMode.mirror,
                    ).createShader(Rect.fromLTWH(
                      -bounds.width + (_controller.value * bounds.width * 2),
                      0,
                      bounds.width * 2,
                      bounds.height,
                    ));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Ícone branco por cima do degradê
                const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Barra inferior
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: widget.currentIndex >= 2
                  ? widget.currentIndex + 1
                  : widget.currentIndex,
              onTap: (index) {
                if (index == 2) return; // pula o botão central (sem ação)
                // ajusta o index real da página
                final pageIndex = index > 2 ? index - 1 : index;
                widget.onItemSelected(pageIndex);
              },
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon(Icons.home, 0),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(Icons.search, 1),
                  label: 'Buscar',
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: '', // espaço para o botão central
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(Icons.list_alt_rounded, 2),
                  label: 'Listagem',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(Icons.person_rounded, 3),
                  label: 'Perfil',
                ),
              ],
            ),
          ),

          // Botão flutuante central
          Positioned(
            bottom: 47, // ajustado para centralizar verticalmente
            child: _buildFloatingActionButton(),
          ),
        ],
      ),
    );
  }
}
