import 'package:flutter/material.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/features/login/login.dart';
import 'package:ngo/l10n/app_localizations.dart';

import '../../components/custom_elevated_button_component.dart';

class LandingButtonSection extends StatelessWidget {
  const LandingButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Column(
      children: [
        CustomElevatedButtonComponent(
          buttonTextStyle: MyFonts.font14BlackBold.copyWith(
            color: Colors.white,
          ),
          buttonColor: MyColors.primaryColor,
          borderColor: MyColors.primaryColor,
          onPressed: () {
            // Navigate to login page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false,
            );
          },
          title: lang.login,
        ),
        const SizedBox(height: 10),
        CustomElevatedButtonComponent(
          buttonTextStyle: MyFonts.font14BlackBold.copyWith(
            color: MyColors.primaryColor,
          ),
          buttonColor: MyColors.backgroundColor,
          borderColor: MyColors.backgroundColor,
          onPressed: () {},
          title: lang.sigup,
        ),

        const SizedBox(height: 20),
        TextButton(
          onPressed: () {},
          child: TextComponent(
            title: lang.continue_as_guest,
            style: MyFonts.font14BlackBold,
          ),
        ),
      ],
    );
  }
}
