import 'dart:io';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  static late final SharedPreferences _sharedPreferences;
  static LocaleCubit _singleton = LocaleCubit._internal(
    Locale(_sharedPreferences.getString("Locale")!),
  );

  factory LocaleCubit() {
    return _singleton;
  }

  LocaleCubit._internal(Locale locale) : super(LocaleSetSuccess(locale));

  LocaleCubit.initial(SharedPreferences sharedPreferences)
    : super(LocaleInitial()) {
    _sharedPreferences = sharedPreferences;
    final String? previousLocale = _sharedPreferences.getString("Locale");

    if (previousLocale != null) {
      final langCode = previousLocale.split("_")[0];
      final countryCode = previousLocale.split("_")[1];
      _singleton = LocaleCubit._internal(Locale(langCode, countryCode));
    } else {
      _sharedPreferences.setString("Locale", platformLocale.toString());
      _singleton = LocaleCubit._internal(platformLocale);
    }
  }

  switchLanguage() {
    final newLocale = (state as LocaleSetSuccess).isEnglish
        ? arabicLocale
        : englishLocale;
    _saveLocale(newLocale);
    emit(LocaleSetSuccess(newLocale));
  }

  Future<bool> _saveLocale(Locale locale) async =>
      _sharedPreferences.setString("Locale", locale.toString());

  Locale get englishLocale => const Locale('en', 'US');

  Locale get arabicLocale => const Locale('ar', 'SA');

  Locale get platformLocale {
    final String langCode = Platform.localeName.split("_")[0];
    if (langCode == "en") {
      return const Locale("en", "US");
    } else if (langCode == "ar") {
      return const Locale("ar", "SA");
    }
    return const Locale("ar", "SA");
  }
}
