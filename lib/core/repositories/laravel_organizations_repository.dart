import 'package:ngo/core/contracts/organizations_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/organization.dart';

final class LaravelOrganizationsRepository extends LaravelRepository
    implements OrganizationsRepository {
  @override
  Future<Organization> fetch(String slug, {String language = 'en'}) async {
    final response = await get('/v1/organizations/$slug' , headers: {
      'Accept-Language': language,
    });
    final data = response['data'] as Map<String, dynamic>;
    return Organization.fromLaravel(data);
  }

  @override
  Future<List<Organization>> fetchAll({String language = 'en'}) async {
    final response = await get('/v1/organizations', headers: {
      'Accept-Language': language,
    });

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Organization.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }
}
