import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const TextWidget({
    super.key,
    required this.label,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
