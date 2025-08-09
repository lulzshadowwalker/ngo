
import 'package:dio/dio.dart';
import 'package:ngo/core/contracts/auth_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';

import '../../models/role.dart';

class LaravelLoginRepository extends LaravelRepository implements AuthRepository{
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
                'attributes': {'token': deviceToken??""},
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
  Future<(AccessToken accessToken, Role role)> registerIndividuals({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required int locationId,
    String? avatar,
  }) async {
    // Create FormData for multipart request
    final formData = FormData.fromMap({
      'data[attributes][name]': name,
      'data[attributes][email]': email,
      'data[attributes][password]': password,
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'location_id': locationId,
    });

    // Add avatar files if provided
    if (avatar != null) {
      formData.files.addAll([
        MapEntry('data[attributes][avatar]', await MultipartFile.fromFile(avatar)),
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
}
