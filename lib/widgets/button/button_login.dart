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
        height: 60,
        width: 200,
        decoration: ShapeDecoration(
          color: Color(0xFFDCB98E),
          shape: RoundedRectangleBorder(
            borderRadius:
                rounded ? BorderRadius.circular(20) : BorderRadius.circular(10),
            side: BorderSide(
              color: Color(0xFF967348),
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'InriaSans',
              letterSpacing: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}
