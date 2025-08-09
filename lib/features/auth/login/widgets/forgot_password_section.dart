import 'package:flutter/material.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/features/components/text_component.dart';

import '../../../../l10n/app_localizations.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AppLocalizations.of(context)!.localeName == "en" ?  Alignment.centerLeft : Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: TextComponent(
          title: AppLocalizations.of(context)!.forgot_fassword,
          style: MyFonts.font14BlackBold.copyWith(
            color: MyColors.primaryColor,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
