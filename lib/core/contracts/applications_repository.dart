import 'package:ngo/models/api_response.dart';
import 'package:ngo/models/application.dart';
import 'package:ngo/models/application_response.dart';

abstract interface class ApplicationsRepository {
  /// Submit a new application
  Future<Application> submit({
    required int opportunityId,
    required List<ApplicationResponse> responses,
  });

  /// Get all applications for the current user
  Future<PaginatedResponse<Application>> fetchAll({
    int page = 1,
    int perPage = 20,
  });

  /// Get single application by ID
  Future<Application> fetch(int id);

  /// Update an existing application (only pending applications)
  Future<Application> update({
    required int id,
    required List<ApplicationResponse> responses,
  });

  /// Delete an application (only pending applications)
  Future<void> deleteApplication(int id);
}
