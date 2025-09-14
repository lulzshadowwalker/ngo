import 'package:ngo/models/organization.dart';

abstract interface class OrganizationsRepository {
  Future<List<Organization>> fetchAll(String accessToken, {String language});
  Future<Organization> fetch(
    String slug,
    String accessToken, {
    String language,
  });
  Future<void> followOrganization(String organizationId);
  Future<void> unfollowOrganization(String organizationId);
  Future<List<Organization>> search(
    String query, {
    String language,
    String? sectorId,
  });
}
