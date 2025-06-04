import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ngo/l10n/app_localizations.dart';
import 'package:ngo/l10n/locale/cubit/locale_cubit.dart';
import 'package:ngo/features/splash/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit(),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NGO-962',
            locale: (localeState is LocaleSetSuccess)
                ? localeState.locale
                : const Locale('en'),
            home: Splash(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
          );
        },
      ),
    );
  }
}
