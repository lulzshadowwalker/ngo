import 'package:dio/dio.dart';
import 'package:ngo/core/contracts/auth_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';

import '../../models/role.dart';

class LaravelLoginRepository extends LaravelRepository
    implements AuthRepository {
  @override
  @override
  Future<(AccessToken accessToken, Role role)> login(
    String email,
    String password, {
    String? deviceToken,
  }) async {
    final response = await post(
      '/v1/auth/login',
      data: {
        'data': {
          'attributes': {'email': email, 'password': password},
          'relationships': {
            'deviceTokens': {
              'data': {
                'attributes': {'token': deviceToken ?? ""},
              },
            },
          },
        },
      },
    );

    final accessToken = response['data']['attributes']['token'] as AccessToken;
    final role = Role.from(response['data']['attributes']['role'] as String);
    return (accessToken, role);
  }

  @override
  Future<void> logout() async {
    await post('/v1/logout');
    // Handle logout logic, e.g., clear user session or token
  }

  @override
  Future<(AccessToken accessToken, Role role)> registerIndividual({
    required String name,
    required String email,
    required String password,
    required int locationId,
    String? avatar,
  }) async {
    // Create FormData for multipart request
    final formData = FormData.fromMap({
      'data[attributes][name]': name,
      'data[attributes][email]': email,
      'data[attributes][password]': password,
      'data[relationships][location][data][id]': locationId,
    });

    // Add avatar files if provided
    if (avatar != null) {
      formData.files.addAll([
        MapEntry(
          'data[attributes][avatar]',
          await MultipartFile.fromFile(avatar),
        ),
        MapEntry('avatar', await MultipartFile.fromFile(avatar)),
      ]);
    }

    final response = await post(
      '/v1/auth/register/individuals',
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    final accessToken = response['data']['attributes']['token'] as AccessToken;
    final role = Role.from(response['data']['attributes']['role'] as String);
    return (accessToken, role);
  }

  @override
  Future<(AccessToken accessToken, Role role)> registerOrganization({
    required String name,
    required String email,
    required String password,
    required int locationId,
    required int sectorId,
    String? bio,
    String? contactEmail,
    String? website,
    String? logo, // File path for logo upload
  }) async {
    // Create FormData for multipart request
    final formData = FormData.fromMap({
      'data[attributes][name]': name,
      'data[attributes][email]': email,
      'data[attributes][contactEmail]': contactEmail,
      'data[attributes][password]': password,
      'data[attributes][website]': website ?? '',
      'data[attributes][bio]': bio ?? '',
      'data[relationships][location][data][id]': locationId,
      'data[relationships][sector][data][id]': sectorId,
    });

    // Add logo file if provided
    if (logo != null) {
      formData.files.addAll([
        MapEntry('data[attributes][logo]', await MultipartFile.fromFile(logo)),
        MapEntry('logo', await MultipartFile.fromFile(logo)),
      ]);
    }

    final response = await post(
      '/v1/auth/register/organizations',
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    final accessToken = response['data']['attributes']['token'] as AccessToken;
    final role = Role.from(response['data']['attributes']['role'] as String);
    return (accessToken, role);
  }






  @override
  Future<void> forgotPassword({String? email}) async {
    if (email == null) {
      throw ArgumentError('Email is required for forgot password');
    }

    try {
      await post(
        '/v1/auth/forgot-password',
        data: {
          "data": {
            "attributes": {"email": email},
          },
        },
      );

      // API responses:
      // 200 => Success - Password reset email sent (or email not found for security)
      // 422 => Too many attempts, user needs to wait before trying again
    } catch (error) {
      // For security reasons, we treat "email not found" as success
      // Only throw errors for actual system issues (rate limiting, server errors, etc.)
      if (error.toString().contains('404') ||
          error.toString().contains('not found') ||
          error.toString().contains('user not found')) {
        // Don't throw error for email not found - treat as success for security
        return;
      }

      // Re-throw other errors (like rate limiting, server errors)
      rethrow;
    }
  }
  
  @override
  Future<void> changePassword({
    required String currentPassword, 
    required String newPassword, 
    required String confirmPassword,
    String? accessToken,
  }) async {
    try {
      await post(
        '/v1/auth/change-password',
        data: {
          'data': {
            'attributes': {
              'current_password': currentPassword,
              'new_password': newPassword,
              'new_password_confirmation': confirmPassword,
            },
          },
        },
        headers: accessToken != null 
            ? {'Authorization': 'Bearer $accessToken'}
            : null,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      // API returns 200 on success with message
      // No need to process response data for password change
      
    } on DioException catch (e) {
      // Handle specific API errors based on status codes
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null && errors is List && errors.isNotEmpty) {
          final firstError = errors[0];
          final detail = firstError['detail'] as String?;
          
          // Handle specific validation errors
          if (detail != null) {
            if (detail.contains('current password is incorrect')) {
              throw Exception('Current password is incorrect');
            } else if (detail.contains('confirmation does not match')) {
              throw Exception('Password confirmation does not match');
            } else if (detail.contains('must be different from the current password')) {
              throw Exception('New password must be different from current password');
            } else if (detail.contains('min:8')) {
              throw Exception('Password must be at least 8 characters long');
            } else {
              throw Exception(detail);
            }
          }
        }
        throw Exception('Password validation failed');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Authentication failed. Please log in again');
      } else if (e.response?.statusCode == 403) {
        throw Exception('You are not authorized to change this password');
      } else if (e.response?.statusCode == 429) {
        throw Exception('Too many password change attempts. Please try again later');
      } else if (e.response?.statusCode == 500) {
        throw Exception('Server error occurred. Please try again later');
      } else {
        throw Exception('Failed to change password: ${e.message}');
      }
    } catch (e) {
      // Handle any other unexpected errors
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}
