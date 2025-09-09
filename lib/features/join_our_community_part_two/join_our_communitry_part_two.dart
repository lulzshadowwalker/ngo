import 'package:hugeicons/hugeicons.dart';
import 'package:ngo/export_tools.dart';

import '../../core/core_export.dart';
import '../join_our_community/join_our_export.dart';
import '../join_the_community/join_the_community_export.dart';

class JoinOurCommunitryPartTwo extends StatelessWidget {
  const JoinOurCommunitryPartTwo({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: HugeIcon(
            icon: lang.localeName == "ar"
                ? HugeIcons.strokeRoundedArrowRight01
                : HugeIcons.strokeRoundedArrowLeft01,
            color: MyColors.primaryColor,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.join_our_community,
              style: MyFonts.font18BlackBold,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.iam_joining_as,
              style: MyFonts.font16Black,
            ),
            const SizedBox(height: 20),
            IamJoiningAsAnSection(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> JoinTheCommunity()));
              },
              title: lang.opptunity_seeker,
              description: AppLocalizations.of(
                context,
              )!.for_personal_use_and_volunteering,
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 20),
            IamJoiningAsAnSection(
              onTap: () {},
              title: lang.consultant,
              description: lang.for_registered_as_consultant,
              icon: Icons.business,
            ),
            const SizedBox(height: 20),
            TermsOfSeerviceSection(lang: lang),
          ],
        ),
      ),
    );
  }
}
