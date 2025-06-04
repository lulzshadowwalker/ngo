// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get helloWorld => 'Hello Arabi!';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get sigup => 'إنشاء حساب جديد';

  @override
  String get connent_evaluate_volunteer => 'تواصل. قيّم. المتطوعين.';

  @override
  String get join_us => 'انضم إلى أكبر مجتمع تطوعي في الأردن';

  @override
  String get continue_as_guest => 'متابعة كزائر';
}
