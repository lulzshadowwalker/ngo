import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  const TextComponent({super.key, required this.title, required this.style});

  final TextStyle style;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: style);
  }
}
