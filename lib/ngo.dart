import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ngo/providers/l10n.dart';
import 'package:ngo/screens/home/home.dart';
import 'package:ngo/screens/splash/splash.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider).locale;
    return MaterialApp(title: 'NGO-962', locale: locale, home: Splash());
  }
}
