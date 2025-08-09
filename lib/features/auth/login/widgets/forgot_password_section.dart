import 'package:flutter/material.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/features/components/text_component.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {},
          child: TextComponent(
            title: "Forgot Password?",
            style: MyFonts.font14BlackBold.copyWith(
              color: MyColors.primaryColor,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
