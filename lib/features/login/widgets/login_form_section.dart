import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/features/components/text_from_field.dart';

class LoginFromSection extends StatelessWidget {
  const LoginFromSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponent(title: "Email", style: MyFonts.font14BlackBold),
          const SizedBox(height: 10),
          AppTextFormField(
            prefixIcon: const HugeIcon(
              icon: HugeIcons.strokeRoundedMail01,
              size: 20,
              color: MyColors.darkGrayColor,
            ),
            hintText: "Enter your email",
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          TextComponent(title: "Password", style: MyFonts.font14BlackBold),
          const SizedBox(height: 10),
          AppTextFormField(
            prefixIcon: const HugeIcon(
              icon: HugeIcons.strokeRoundedLockPassword,
              size: 20,
              color: MyColors.darkGrayColor,
            ),
            hintText: "Enter your password",
            obscureText: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedViewOffSlash,
                size: 20,
                color: MyColors.darkGrayColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
