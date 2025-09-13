import 'package:ngo/core/contracts/user_management_regpository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/user.dart';
import 'package:ngo/models/user_preferences.dart';
import 'dart:io';

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

  @override
  Future<User> updateProfile(
    String accessToken,
    Map<String, dynamic> profileData, {
    File? avatarFile,
  }) async {
    final Map<String, dynamic> requestData = {
      'data': {
        'attributes': {},
        'relationships': {},
      },
    };

    // Add profile attributes
    if (profileData['name'] != null) {
      requestData['data']['attributes']['name'] = profileData['name'];
    }
    if (profileData['email'] != null) {
      requestData['data']['attributes']['email'] = profileData['email'];
    }
    if (profileData['bio'] != null) {
      requestData['data']['attributes']['bio'] = profileData['bio'];
    }
    if (profileData['birthdate'] != null) {
      requestData['data']['attributes']['birthdate'] = profileData['birthdate'];
    }
    if (profileData['website'] != null) {
      requestData['data']['attributes']['website'] = profileData['website'];
    }
    if (profileData['contactEmail'] != null) {
      requestData['data']['attributes']['contactEmail'] = profileData['contactEmail'];
    }

    // Add relationships
    if (profileData['locationId'] != null) {
      requestData['data']['relationships']['location'] = {
        'data': {'id': profileData['locationId']}
      };
    }
    if (profileData['skillIds'] != null && profileData['skillIds'] is List) {
      requestData['data']['relationships']['skills'] = {
        'data': (profileData['skillIds'] as List)
            .map((id) => {'id': id})
            .toList()
      };
    }
    if (profileData['sectorId'] != null) {
      requestData['data']['relationships']['sector'] = {
        'data': {'id': profileData['sectorId']}
      };
    }

    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final response = await patchMultipart(
      '/v1/me',
      headers: headers,
      data: requestData,
      files: avatarFile != null ? {'avatar': avatarFile} : null,
    );

    final data = response['data'] as Map<String, dynamic>;
    return User.fromLaravel(data);
  }
}
