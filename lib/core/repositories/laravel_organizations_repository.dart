import 'dart:developer';

import 'package:ngo/core/contracts/organizations_repository.dart';
import 'package:ngo/core/helpers/helper.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/organization.dart';

final class LaravelOrganizationsRepository extends LaravelRepository
    implements OrganizationsRepository {
  @override
  Future<Organization> fetch(String slug, {String language = 'en'}) async {
    final authorization = await SharedPrefHelper.getAccessToken();
    

        
    final response = await get(
      '/v1/organizations/$slug',
      headers: {
        'Accept-Language': language,
        'Authorization': 'Bearer $authorization',
      },
    );
    final data = response['data'] as Map<String, dynamic>;
    return Organization.fromLaravel(data);
  }

  @override
  Future<List<Organization>> fetchAll({String language = 'en'}) async {
    final authorization = await SharedPrefHelper.getAccessToken();


    final response = await get(
      '/v1/organizations',
      headers: {
        'Accept-Language': language,
        'Authorization': 'Bearer $authorization',
      },
    );

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Organization.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> followOrganization(String organizationId) async {
    final authorization = await SharedPrefHelper.getAccessToken();
    log('Raw authorization token: "$authorization"');
    log('Token length: ${authorization.length}');
    log('Token starts with Bearer: ${authorization.startsWith('Bearer ')}');
    
    if (authorization.isEmpty) {
      throw Exception('Authentication required. Please log in again.');
    }
    

  
    
    try {
      await post(
        '/v1/organizations/$organizationId/follows',
        headers: {'Authorization': 'Bearer $authorization'},
      );
      log('Successfully followed organization: $organizationId');
    } catch (error) {
      log('Error following organization: $error');
      if (error.toString().contains('401')) {
        throw Exception('Authentication failed. Please log in again.');
      } else if (error.toString().contains('404')) {
        throw Exception('Organization not found.');
      } else if (error.toString().contains('409')) {
        throw Exception('You are already following this organization.');
      } else {
        throw Exception('Failed to follow organization. Please try again.');
      }
    }
  }

  @override
  Future<void> unfollowOrganization(String organizationId) async {
    final authorization = await SharedPrefHelper.getAccessToken();
    log("Raw authorization token: $authorization");
    
    if (authorization.isEmpty) {
      throw Exception('Authentication required. Please log in again.');
    }
    

    
    try {
      await delete(
        '/v1/organizations/$organizationId/follows',
        headers: {'Authorization': 'Bearer $authorization'},
      );
      log('Successfully unfollowed organization: $organizationId');
    } catch (error) {
      log('Error unfollowing organization: $error');
      if (error.toString().contains('401')) {
        throw Exception('Authentication failed. Please log in again.');
      } else if (error.toString().contains('404')) {
        throw Exception('Organization not found or you are not following it.');
      } else {
        throw Exception('Failed to unfollow organization. Please try again.');
      }
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
