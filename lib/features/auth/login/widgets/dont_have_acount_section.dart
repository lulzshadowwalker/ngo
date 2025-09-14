import 'package:flutter/material.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/l10n/app_localizations.dart';

import '../../../join_our_community/join_our_community.dart';

class DontHaveAcountSection extends StatelessWidget {
  const DontHaveAcountSection({super.key, required this.lang});

  final AppLocalizations lang;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JionOurCommunity()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextComponent(
              title: AppLocalizations.of(context)!.dont_have_an,
              style: MyFonts.font14BlackBold,
            ),
            const SizedBox(width: 5),
            TextComponent(
              title: lang.sigup,
              style: MyFonts.font14BlackBold.copyWith(
                color: MyColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
