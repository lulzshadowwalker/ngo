import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ngo/constant/app_assets.dart';
import 'package:ngo/screens/components/logo_app.dart';
import 'package:ngo/screens/components/text_component.dart';
import 'package:ngo/theme/my_colors.dart';
import 'package:ngo/theme/my_fonts.dart';

import '../../providers/l10n.dart';
import '../components/custom_elevated_button_component.dart';

class Landing extends ConsumerWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localeProvider);

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
            title: "Connect. Evaluate. Volunteer.",
            style: MyFonts.font20Black,
          ),
          TextComponent(
            title: "Join Jordan's largest volunteering community",
            style: MyFonts.font14Black,
          ),
          const SizedBox(height: 20),

          LandingButtonSection(),

          const SizedBox(height: 20),
          LanguageButtonSection(),
        ],
      ),
    );
  }
}

class LanguageButtonSection extends ConsumerWidget {
  const LanguageButtonSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            ref.read(localeProvider.notifier).switchLanguage();
          },
          child: TextComponent(
            title: "English",
            style: MyFonts.font14BlackBold.copyWith(
              color: localeState.isEnglish
                  ? MyColors.primaryColor
                  : MyColors.borderColor,
            ),
          ),
        ),
        Container(
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.darkGrayColor, width: 1),
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(localeProvider.notifier).switchLanguage();
          },
          child: TextComponent(
            title: "العربية",
            style: MyFonts.font14BlackBold.copyWith(
              color: localeState.isArabic
                  ? MyColors.primaryColor
                  : MyColors.borderColor,
            ),
          ),
        ),
      ],
    );
  }
}

class LandingButtonSection extends StatelessWidget {
  const LandingButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          title: "Log in",
        ),
        const SizedBox(height: 10),
        CustomElevatedButtonComponent(
          buttonTextStyle: MyFonts.font14BlackBold.copyWith(
            color: MyColors.primaryColor,
          ),
          buttonColor: MyColors.backgroundColor,
          borderColor: MyColors.backgroundColor,
          onPressed: () {
            // Navigate to login page
          },
          title: "Sign up",
        ),

        const SizedBox(height: 20),
        TextButton(
          onPressed: () {},
          child: TextComponent(
            title: "Continue as Guest",
            style: MyFonts.font14BlackBold,
          ),
        ),
      ],
    );
  }
}
