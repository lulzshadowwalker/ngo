import 'package:ngo/core/contracts/organizations_repository.dart';
import 'package:ngo/core/helpers/helper.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/organization.dart';

final class LaravelOrganizationsRepository extends LaravelRepository
    implements OrganizationsRepository {
  @override
  Future<Organization> fetch(String slug, {String language = 'en'}) async {
    final response = await get(
      '/v1/organizations/$slug',
      headers: {'Accept-Language': language},
    );
    final data = response['data'] as Map<String, dynamic>;
    return Organization.fromLaravel(data);
  }

  @override
  Future<List<Organization>> fetchAll({String language = 'en'}) async {
    final response = await get(
      '/v1/organizations',
      headers: {'Accept-Language': language},
    );

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Organization.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> followOrganization(String organizationId) async {
    final authorization = await SharedPrefHelper.getAccessToken();
    try {
      await post(
        '/v1/organizations/$organizationId/follows',
        headers: {'Authorization': 'Bearer $authorization'},
      );
    } catch (error) {
      throw Exception('Failed to follow organization: $error');
    }
  }

  @override
  Future<void> unfollowOrganization(String organizationId) async {
    final authorization = await SharedPrefHelper.getAccessToken();
    try {
      await delete(
        '/v1/organizations/$organizationId/follows',
        headers: {'Authorization': 'Bearer $authorization'},
      );
    } catch (error) {
      throw Exception('Failed to unfollow organization: $error');
    }
  }

  @override
  Future<List<Organization>> search(
    String query, {
    String language = 'en',
    String? sectorId,
  }) {
    final Map<String, String> params = {'query': query};
    if (sectorId != null) {
      params['sector'] = sectorId;
    }
    final queryString = Uri(queryParameters: params).query;
    return get(
      '/v1/organizations/search${queryString.isNotEmpty ? '?$queryString' : ''}',
      headers: {'Accept-Language': language},
    ).then((response) {
      final data = response['data'] as List<dynamic>;
      return data
          .map((item) => Organization.fromLaravel(item as Map<String, dynamic>))
          .toList();
    });
  }
}
