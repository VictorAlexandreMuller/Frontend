import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedGradientBorderContainer extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final double borderWidth;

  const AnimatedGradientBorderContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.borderWidth = 3,
  });

  @override
  State<AnimatedGradientBorderContainer> createState() => _AnimatedGradientBorderContainerState();
}

class _AnimatedGradientBorderContainerState extends State<AnimatedGradientBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFF47CFE3),
                Color(0xFFF279A4),
                Color(0xFF47CFE3),
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: GradientRotation(_controller.value * 2 * math.pi),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(widget.borderWidth),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius - widget.borderWidth),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
