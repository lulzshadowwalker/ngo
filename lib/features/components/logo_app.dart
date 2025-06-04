import 'package:flutter/material.dart';
import 'package:ngo/core/constant/app_assets.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({super.key, this.height = 320, this.logoApp = AppAssets.logo});
  final double height;
  final String logoApp;
  @override
  Widget build(BuildContext context) {
    return Image.asset(logoApp, height: height);
  }
}
