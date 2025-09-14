import 'package:ngo/core/contracts/applications_repository.dart';
import 'package:ngo/core/helpers/helper.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/api_response.dart';
import 'package:ngo/models/application.dart';
import 'package:ngo/models/application_response.dart';

final class LaravelApplicationsRepository extends LaravelRepository
    implements ApplicationsRepository {
  @override
  Future<Application> submit({
    required int opportunityId,
    required List<ApplicationResponse> responses,
  }) async {
    final authorization = await SharedPrefHelper.getAccessToken();
    final userId = await SharedPrefHelper.getString('user_id');

    final requestData = {
      'opportunity_id': opportunityId,
      'user_id': int.parse(userId),
      'responses': responses
          .map((response) => response.toSubmissionJson())
          .toList(),
    };

    final response = await post(
      '/v1/applications',
      data: requestData,
      headers: {'Authorization': 'Bearer $authorization'},
    );

    final data = response['data'] as Map<String, dynamic>;
    return Application.fromJson(data);
  }

  @override
  Future<PaginatedResponse<Application>> fetchAll({
    int page = 1,
    int perPage = 20,
  }) async {
    final authorization = await SharedPrefHelper.getAccessToken();

    final response = await get(
      '/v1/applications',
      queryParameters: {'page': page, 'per_page': perPage},
      headers: {'Authorization': 'Bearer $authorization'},
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => Application.fromJson(json),
    );
  }

  @override
  Future<Application> fetch(int id) async {
    final authorization = await SharedPrefHelper.getAccessToken();

    final response = await get(
      '/v1/applications/$id',
      headers: {'Authorization': 'Bearer $authorization'},
    );

    final data = response['data'] as Map<String, dynamic>;
    return Application.fromJson(data);
  }

  @override
  Future<Application> update({
    required int id,
    required List<ApplicationResponse> responses,
  }) async {
    final authorization = await SharedPrefHelper.getAccessToken();

    final requestData = {
      'responses': responses
          .map((response) => response.toSubmissionJson())
          .toList(),
    };

    final response = await patch(
      '/v1/applications/$id',
      data: requestData,
      headers: {'Authorization': 'Bearer $authorization'},
    );

    final data = response['data'] as Map<String, dynamic>;
    return Application.fromJson(data);
  }

  @override
  Future<void> deleteApplication(int id) async {
    final authorization = await SharedPrefHelper.getAccessToken();

    await super.delete(
      '/v1/applications/$id',
      headers: {'Authorization': 'Bearer $authorization'},
    );
  }
}
