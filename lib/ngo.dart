import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/features/main_nav/main_nav_export.dart';
import 'package:ngo/features/splash/splash.dart';
import 'package:ngo/l10n/app_localizations.dart';
import 'package:ngo/l10n/locale/cubit/locale_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => MainNavCubit()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return MaterialApp(
              theme: AppTheme.lightTheme,

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
