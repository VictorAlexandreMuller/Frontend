import 'package:flutter/material.dart';

class ButtonLogin extends StatefulWidget {
  const ButtonLogin({
    super.key,
    this.onPressed,
    required this.text,
    required this.enabled,
    required this.rounded,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool enabled;
  final bool rounded;

  @override
  State<ButtonLogin> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFF3B3B3B);
    final borderRadius = widget.rounded
        ? BorderRadius.circular(30)
        : BorderRadius.circular(10);

    return GestureDetector(
      onTapDown: widget.enabled ? _handleTapDown : null,
      onTapUp: widget.enabled ? _handleTapUp : null,
      onTapCancel: _handleTapCancel,
      onTap: widget.enabled ? widget.onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 55,
        width: double.infinity,
        child: Stack(
          children: [
            // fundo do botão
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius,
                boxShadow: !_isPressed
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(4, 4),
                          blurRadius: 10,
                        ),
                      ]
                    : [],
              ),
            ),

            // brilho interno branco sutil ao pressionar
            if (_isPressed)
              Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.08), // bem sutil
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

            // texto do botão
            Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'InriaSans',
                  letterSpacing: 3.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
