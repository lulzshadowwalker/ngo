import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:ngo/export_tools.dart';
import '../../core/core_export.dart';

class TermsOfSeerviceSection extends StatelessWidget {
  const TermsOfSeerviceSection({super.key, required this.lang});

  final AppLocalizations lang;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
          children: [
            TextSpan(
              text: "${lang.by_continuing_you_agree_to} ",
              style: MyFonts.font14Black,
            ),
            TextSpan(
              text: AppLocalizations.of(context)!.terms_and_conditions,
              style: MyFonts.font14BlackBold.copyWith(
                color: MyColors.primaryColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigate to Terms of Service page
                },
            ),
            TextSpan(text: " ${lang.and} ", style: MyFonts.font14Black),
            TextSpan(
              text: AppLocalizations.of(context)!.privacy_policy,
              style: MyFonts.font14BlackBold.copyWith(
                color: MyColors.primaryColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigate to Privacy Policy page
                },
            ),
          ],
        ),
      ),
    );
  }
}
