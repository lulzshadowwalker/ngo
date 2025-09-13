import 'package:ngo/core/contracts/opportunities_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/api_response.dart';
import 'package:ngo/models/opportunity.dart';

final class LaravelOpportunitiesRepository extends LaravelRepository
    implements OpportunitiesRepository {
  @override
  Future<PaginatedResponse<Opportunity>> fetchAll({
    String language = 'en',
    int page = 1,
    int perPage = 20,
    String? search,
    List<String>? tags,
    int? sectorId,
    int? organizationId,
    int? locationId,
    double? lat,
    double? lng,
    double? radius,
    int? durationMax,
    DateTime? expiryAfter,
    bool? isFeatured,
    String? sort,
    String? direction,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'per_page': perPage};

    if (search != null) queryParams['search'] = search;
    if (tags != null) {
      for (int i = 0; i < tags.length; i++) {
        queryParams['tags[$i]'] = tags[i];
      }
    }
    if (sectorId != null) queryParams['sector_id'] = sectorId;
    if (organizationId != null) queryParams['organization_id'] = organizationId;
    if (locationId != null) queryParams['location_id'] = locationId;
    if (lat != null) queryParams['lat'] = lat;
    if (lng != null) queryParams['lng'] = lng;
    if (radius != null) queryParams['radius'] = radius;
    if (durationMax != null) queryParams['duration_max'] = durationMax;
    if (expiryAfter != null) {
      queryParams['expiry_after'] = expiryAfter.toIso8601String().split('T')[0];
    }
    if (isFeatured != null) queryParams['is_featured'] = isFeatured;
    if (sort != null) queryParams['sort'] = sort;
    if (direction != null) queryParams['direction'] = direction;

    final response = await get(
      '/v1/opportunities',
      queryParameters: queryParams,
      headers: {'Accept-Language': language},
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => Opportunity.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<Opportunity>> fetchFeatured({
    String language = 'en',
    int page = 1,
    int perPage = 10,
  }) async {
    final response = await get(
      '/v1/opportunities/featured',
      queryParameters: {'page': page, 'per_page': perPage},
      headers: {'Accept-Language': language},
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => Opportunity.fromJson(json),
    );
  }

  @override
  Future<Opportunity> fetch(String id, {String language = 'en'}) async {
    final response = await get(
      '/v1/opportunities/$id',
      headers: {'Accept-Language': language},
    );

    final data = response['data'] as Map<String, dynamic>;
    return Opportunity.fromJson(data);
  }

  @override
  Future<Map<String, dynamic>> getStats() async {
    final response = await get('/v1/opportunities/stats');
    return response['data'] as Map<String, dynamic>;
  }

  @override
  Future<List<Opportunity>> search(
    String query, {
    String language = 'en',

    int? sectorId,
  }) async {
    final queryParams = <String, dynamic>{'query': query};

    if (sectorId != null) {
      queryParams['section'] =
          sectorId; // Changed to 'section' to match your endpoint
    }

    return
        await get(
          '/v1/opportunities/search',
          queryParameters: queryParams,
          headers: {'Accept-Language': language},
        ).then((response) {
          final data = response['data'] as List<dynamic>;
          return data
              .map((item) => Opportunity.fromJson(item as Map<String, dynamic>))
              .toList();
        });
  }
}
