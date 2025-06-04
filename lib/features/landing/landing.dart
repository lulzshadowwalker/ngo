import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/constant/app_assets.dart';
import 'package:ngo/l10n/app_localizations.dart';
import 'package:ngo/locale/cubit/locale_cubit.dart';
import 'package:ngo/features/components/logo_app.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/theme/my_colors.dart';
import 'package:ngo/theme/my_fonts.dart';
import '../components/custom_elevated_button_component.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView(
        shrinkWrap: true,

        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        children: [
          LogoApp(logoApp: AppAssets.logo2, height: 320),
          const SizedBox(height: 40),
          TextComponent(
            title: lang.connent_evaluate_volunteer,
            style: MyFonts.font20Black,
          ),
          TextComponent(title: lang.join_us, style: MyFonts.font14Black),
          const SizedBox(height: 20),

          LandingButtonSection(),

          const SizedBox(height: 20),
          LanguageButtonSection(),
        ],
      ),
    );
  }
}

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
