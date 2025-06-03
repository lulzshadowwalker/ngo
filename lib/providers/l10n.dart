import 'dart:io';
import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ngo/provider/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleState {
  final Locale locale;
  final bool isInitialized;

  const LocaleState({required this.locale, this.isInitialized = true});

  String get languageCode => locale.languageCode;
  String get countryCode => locale.countryCode ?? '';
  bool get isEnglish => languageCode == "en";
  bool get isArabic => languageCode == "ar";

  LocaleState copyWith({Locale? locale, bool? isInitialized}) {
    return LocaleState(
      locale: locale ?? this.locale,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleState &&
          runtimeType == other.runtimeType &&
          locale == other.locale &&
          isInitialized == other.isInitialized;

  @override
  int get hashCode => locale.hashCode ^ isInitialized.hashCode;
}

const englishLocale = Locale('en', 'US');
const arabicLocale = Locale('ar', 'SA');

final platformLocaleProvider = Provider<Locale>((ref) {
  final String langCode = Platform.localeName.split("_")[0];
  if (langCode == "en") {
    return englishLocale;
  }

  if (langCode == "ar") {
    return arabicLocale;
  }

  return arabicLocale;
});

class LocaleNotifier extends StateNotifier<LocaleState> {
  final SharedPreferences _sharedPreferences;
  final Locale _platformLocale;

  LocaleNotifier(this._sharedPreferences, this._platformLocale)
    : super(LocaleState(locale: arabicLocale, isInitialized: false)) {
    _initializeLocale();
  }

  static const String _localeKey = "Locale";

  void _initializeLocale() {
    final String? savedLocale = _sharedPreferences.getString(_localeKey);

    if (savedLocale == null) {
      _setDefaultLocale();
      return;
    }

    final parts = savedLocale.split("_");
    if (parts.length < 2) {
      _setDefaultLocale();
      return;
    }

    final langCode = parts[0];
    final countryCode = parts[1];
    state = LocaleState(locale: Locale(langCode, countryCode));
  }

  void _setDefaultLocale() {
    _saveLocale(_platformLocale);
    state = LocaleState(locale: _platformLocale);
  }

  Future<void> switchLanguage() async {
    final newLocale = state.isEnglish ? arabicLocale : englishLocale;
    await _saveLocale(newLocale);
    state = state.copyWith(locale: newLocale);
  }

  Future<void> setLocale(Locale locale) async {
    await _saveLocale(locale);
    state = state.copyWith(locale: locale);
  }

  Future<bool> _saveLocale(Locale locale) async {
    return _sharedPreferences.setString(_localeKey, locale.toString());
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, LocaleState>((
  ref,
) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final platformLocale = ref.watch(platformLocaleProvider);

  return LocaleNotifier(sharedPreferences, platformLocale);
});
