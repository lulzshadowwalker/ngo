import 'package:ngo/models/api_response.dart';
import 'package:ngo/models/opportunity.dart';

abstract interface class OpportunitiesRepository {
  /// Get all opportunities with optional filtering and pagination
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
  });

  /// Get featured opportunities
  Future<PaginatedResponse<Opportunity>> fetchFeatured({
    String language = 'en',
    int page = 1,
    int perPage = 10,
  });

  /// Get single opportunity by ID
  Future<Opportunity> fetch(
    String id, {
    String language = 'en',
  });

  /// Get platform statistics
  Future<Map<String, dynamic>> getStats();

  /// Search opportunities by query
  Future<PaginatedResponse<Opportunity>> search(
    String query, {
    String language = 'en',
    int page = 1,
    int perPage = 20,
    List<String>? tags,
    int? sectorId,
    int? locationId,
  });
}
