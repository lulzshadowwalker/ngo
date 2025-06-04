import 'package:flutter/material.dart';
import 'package:ngo/features/components/text_component.dart';

import '../../theme/my_colors.dart';

class CustomElevatedButtonComponent extends StatelessWidget {
  const CustomElevatedButtonComponent({
    super.key,
    required this.buttonTextStyle,
    this.buttonColor = MyColors.primaryColor,
    this.borderColor = MyColors.primaryColor,
    required this.onPressed,
    this.title = "Log in",
  });
  final TextStyle buttonTextStyle;
  final Color buttonColor;
  final Color borderColor;
  final void Function() onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        fixedSize: const Size(300, 50),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: MyColors.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: TextComponent(title: title, style: buttonTextStyle),
    );
  }
}
