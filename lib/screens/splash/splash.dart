import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ngo/screens/components/text_component.dart';
import 'package:ngo/screens/landing/landing.dart';
import 'package:ngo/theme/my_fonts.dart';

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
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            TextComponent(
              title: "Connect. Evaluate. Volunteer.",
              style: MyFonts.font20Black,
            ),
            TextComponent(
              title: "Join Jordan's largest volunteering community",
              style: MyFonts.font14Black,
            ),
          ],
        ),
      ),
    );
  }
}
