import 'package:ngo/models/organization.dart';

abstract interface class OrganizationsRepository {
  Future<List<Organization>> fetchAll({String language});
  Future<Organization> fetch(String slug, {String language});
  Future<void> followOrganization(String organizationId);
  Future<void> unfollowOrganization(String organizationId);
}
