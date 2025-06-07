import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  const TextComponent({
    super.key,
    required this.title,
    required this.style,
    this.textAlign = TextAlign.center,
    this.maxLines = 3,
  });

  final TextStyle style;
  final String title;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
