import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({
    super.key,
    required this.label,
    required this.isPassword,
    this.controller,
  });

  final String label;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  _InputLoginState createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF3B3B3B), // cinza escuro atualizado
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.isPassword,
        enableSuggestions: !widget.isPassword,
        autocorrect: !widget.isPassword,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white, // texto branco
          fontFamily: "Inter",
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Colors.white, // placeholder branco
            fontSize: 10,
            fontFamily: "Inter",
            letterSpacing: 3.0,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
