import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({
    super.key,
    required this.label,
  });

  final String label;

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
    return TextFormField(
      focusNode: _focusNode,
      initialValue: '',
      style: TextStyle(
        fontSize: 12, // Diminui o tamanho do texto digitado
        color: Colors.white,
        fontFamily: "Inter",
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontFamily: "Inter",
          letterSpacing: 3.0,
        ),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }
}