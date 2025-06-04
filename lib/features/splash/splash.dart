import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ngo/core/core_export.dart';
import 'package:ngo/export_tools.dart';
import '../components/text_component.dart';
import '../landing/landing.dart';

class Splash extends HookWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () async {
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Landing()),
            (route) => false,
          );
        }
      });

      return null;
    }, const []);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        children: [
          const SizedBox(height: 40),
          LogoApp(),
          const SizedBox(height: 20),
          TextComponent(
            title: "NGO 962",
            style: MyFonts.font28BlackBold.copyWith(
              color: MyColors.primaryColor,
            ),
          ),
          const SizedBox(height: 30),
          TextComponent(
            title: "Connect. Evaluate. Volunteer.",
            style: MyFonts.font22BlackBold,
          ),
          const SizedBox(height: 10),
          TextComponent(
            title: "Join Jordan's largest volunteering community",
            style: MyFonts.font16Black,
          ),
        ],
      ),
    );
  }
}
