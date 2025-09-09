import '../../models/static_page.dart';

abstract interface class StaticPageRepository {
  Future<StaticPage> aboutUs(String locale);
  Future<StaticPage> privacyPolicy(String locale);
  Future<StaticPage> termsAndConditions(String locale);
}
