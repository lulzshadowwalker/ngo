

import '../../models/role.dart';
typedef AccessToken = String;


abstract class AuthRepository {
  /// Logs in a user with the given [email] and [password].
  ///
  /// Returns a [Map<String, dynamic>] containing user data on success.
   Future<(AccessToken accessToken, Role role)> login(
    String email,
    String password, {
    String? deviceToken,
  });


  /// Logs out the current user.
  ///
  /// Returns a [Future<void>] that completes when the logout is successful.
  Future<void> logout();


  /// Registers a new individual user.
  ///
  /// Returns a [Future<(AccessToken, Role)>] containing the access token and role on success.
  Future<(AccessToken accessToken, Role role)> registerIndividuals({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required int locationId,
    String? avatar, // File path for avatar upload
  });



}
