import 'package:ngo/core/contracts/user_management_regpository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/user.dart';
import 'package:ngo/models/user_preferences.dart';

final class LaravelUserManagementRepository extends LaravelRepository
    implements UserManagementRepository {
  @override
  Future<User> getCurrentUser(String accessToken) async {
    final response = await get(
      '/v1/me',
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final data = response['data'] as Map<String, dynamic>;
    return User.fromLaravel(data);
  }

  @override
  Future<UserPreferences> getUserPreferences(String accessToken) async {
    final response = await get(
      '/v1/me/preferences',
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final data = response['data'] as Map<String, dynamic>;
    return UserPreferences.fromLaravel(data);
  }

  @override
  Future<UserPreferences> updateUserPreferences(
    String accessToken,
    Map<String, dynamic> preferences,
  ) async {
    final response = await patch(
      '/v1/me/preferences',
      headers: {'Authorization': 'Bearer $accessToken'},
      data: {
        'data': {
          'attributes': {
            if (preferences['language'] != null) 'language': preferences['language'],
            if (preferences['pushNotifications'] != null) 'pushNotifications': preferences['pushNotifications'],
            if (preferences['emailNotifications'] != null) 'emailNotifications': preferences['emailNotifications'],
            if (preferences['profileVisibility'] != null) 'profileVisibility': preferences['profileVisibility'],
          },
        },
      },
    );

    final data = response['data'] as Map<String, dynamic>;
    return UserPreferences.fromLaravel(data);
  }
}
