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
            'language': preferences['language'],
            'pushNotifications': preferences['pushNotifications'],
            'emailNotifications': preferences['emailNotifications'],
            'profileVisibility': preferences['profileVisibility'],
          },
        },
        'language': preferences['language'],
        'appearance': preferences['appearance'],
        'email_notifications': preferences['emailNotifications'],
        'push_notifications': preferences['pushNotifications'],
        'profile_visibility': preferences['profileVisibility'],
      },
    );

    final data = response['data'] as Map<String, dynamic>;
    return UserPreferences.fromLaravel(data);
  }
}
