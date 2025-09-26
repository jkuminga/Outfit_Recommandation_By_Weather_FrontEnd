import 'package:flutter/material.dart';

class ShadowEffectedText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontweight;
  const ShadowEffectedText({
    super.key,
    required this.text,
    required this.size,
    this.fontweight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: fontweight,
        shadows: [Shadow(blurRadius: 5, offset: Offset(0, 1))],
      ),
    );
  }
}
