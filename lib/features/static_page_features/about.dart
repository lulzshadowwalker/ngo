import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/static_page_features/privacy_policy.dart';

import 'terms_of_service.dart';

class AboutSection extends HookWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(lang.about),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: MyColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              // Logo
              Image.asset("assets/images/aboutLogo.png", height: 150),
              const SizedBox(height: 16),
              Text(
                lang.version,
                style: MyFonts.font14Black.copyWith(color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Mission
              Align(
                alignment: Alignment.centerLeft,
                child: Text(lang.our_mission, style: MyFonts.font16BlackBold),
              ),
              const SizedBox(height: 8),
              Text(
                lang.mission_description,
                style: MyFonts.font14Black.copyWith(
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              // Features
              _AboutFeature(
                icon: Icons.groups,
                title: lang.youth_engagement,
                description: lang.youth_engagement_description,
              ),
              _AboutFeature(
                icon: Icons.bar_chart,
                title: lang.ngo_evaluation,
                description: lang.ngo_evaluation_description,
              ),
              _AboutFeature(
                icon: Icons.people_alt,
                title: lang.community_building,
                description: lang.community_building_description,
              ),
              const SizedBox(height: 32),
              // Links
              Divider(height: 32),
              ListTile(
                title: Text(lang.privacy_policy_title, style: MyFonts.font14BlackBold),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyView()));
                },
                contentPadding: EdgeInsets.zero,
              ),
              ListTile(
                title: Text(
                  lang.terms_of_service_title,
                  style: MyFonts.font14BlackBold,
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TermsOfService()));
                },
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              // Footer
              Text(
                lang.all_rights_reserved,
                style: MyFonts.font12Black.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const _AboutFeature({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: MyColors.primaryColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: MyFonts.font14BlackBold),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: MyFonts.font12Black.copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
