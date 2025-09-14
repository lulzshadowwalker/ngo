import 'package:ngo/export_tools.dart';
import 'package:ngo/features/join_our_community_part_two/join_our_communitry_part_two.dart';

import '../../core/core_export.dart';
import '../../core/widgets/back_button.dart';
import '../register_organization/register_organization_view.dart';
import 'join_our_export.dart';

class JionOurCommunity extends StatelessWidget {
  const JionOurCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: BackButtonWidgets(lang: lang),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinOurCommunitryPartTwo(),
                  ),
                );
              },
              title: AppLocalizations.of(context)!.individual,
              description: AppLocalizations.of(
                context,
              )!.for_personal_use_and_volunteering,
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 20),
            IamJoiningAsAnSection(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterOrganizationView(),
                  ),
                );
              },
              title: AppLocalizations.of(context)!.organization,
              description: AppLocalizations.of(
                context,
              )!.for_registered_organizations,
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
