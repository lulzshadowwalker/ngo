import 'package:ngo/core/contracts/organizations_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/organization.dart';

final class LaravelOrganizationsRepository extends LaravelRepository
    implements OrganizationsRepository {
  @override
  Future<Organization> fetch(String slug, {String language = 'en'}) async {
    final response = await get('/$language/organizations/$slug');
    final data = response['data'] as Map<String, dynamic>;
    return Organization.fromLaravel(data);
  }

  @override
  Future<List<Organization>> fetchAll({String language = 'en'}) async {
    final response = await get('/$language/organizations');

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Organization.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }
}
