import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  const TextComponent({
    super.key,
    required this.title,
    required this.style,
    this.textAlign = TextAlign.center,
  });

  final TextStyle style;
  final String title;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: style, textAlign: textAlign);
  }
}
