

import 'package:ngo/core/repositories/laravel_repository.dart';

import '../../models/static_page.dart';
import '../contracts/static_page_repository.dart';

final class LaravelStaticPageRepository extends LaravelRepository
    implements StaticPageRepository {
  @override
  Future<StaticPage> aboutUs(String locale) async {
    final response = await get(
      '/v1/pages/about-us',
      headers: {'Accept-Language': locale},
    );

    final data = response['data'] as Map<String, dynamic>;
    return StaticPage.fromLaravel(data);
  }

  @override
  Future<StaticPage> privacyPolicy(String locale) async {
    final response = await get(
      '/v1/pages/privacy-policy',
      headers: {'Accept-Language': locale},
    );

    final data = response['data'] as Map<String, dynamic>;
    return StaticPage.fromLaravel(data);
  }

  @override
  Future<StaticPage> termsAndConditions(String locale) async {
    final response = await get(
      '/v1/pages/terms-and-conditions',
      headers: {'Accept-Language': locale},
    );

    final data = response['data'] as Map<String, dynamic>;
    return StaticPage.fromLaravel(data);
  }
}
