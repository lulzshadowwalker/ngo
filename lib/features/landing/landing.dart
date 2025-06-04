import 'package:flutter/material.dart';
import 'package:ngo/core/constant/app_assets.dart';
import 'package:ngo/features/landing/widgets/lading_button_section.dart';
import 'package:ngo/features/landing/widgets/language_button_section.dart';
import 'package:ngo/l10n/app_localizations.dart';
import 'package:ngo/features/components/logo_app.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/core/theme/my_fonts.dart';

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
