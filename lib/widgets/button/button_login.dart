import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      child: Container(
        height: 55,
        width: 200,
        decoration: BoxDecoration(
          color: Color(0xFFDCB98E),
          borderRadius:
              rounded ? BorderRadius.circular(30) : BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFF967348),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              fontFamily: 'InriaSans',
              letterSpacing: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}
