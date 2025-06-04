import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/l10n/app_localizations.dart';
import 'package:ngo/l10n/locale/cubit/locale_cubit.dart';

class LanguageButtonSection extends StatelessWidget {
  const LanguageButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var cubit = context.read<LocaleCubit>();

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        final isEnglish = state is LocaleSetSuccess && state.isEnglish;
        final isArabic = state is LocaleSetSuccess && state.isArabic;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => cubit.switchLanguage(),
              child: TextComponent(
                title: lang.english,
                style: MyFonts.font14BlackBold.copyWith(
                  color: isEnglish
                      ? MyColors.primaryColor
                      : MyColors.borderColor,
                ),
              ),
            ),
            Container(
              height: 20,
              width: 1,
              color: MyColors.darkGrayColor,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            TextButton(
              onPressed: isArabic ? null : () => cubit.switchLanguage(),
              child: TextComponent(
                title: lang.arabic,
                style: MyFonts.font14BlackBold.copyWith(
                  color: isArabic
                      ? MyColors.primaryColor
                      : MyColors.borderColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
