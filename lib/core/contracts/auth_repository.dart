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
  Future<(AccessToken accessToken, Role role)> registerIndividual({
    required String name,
    required String email,
    required String password,
    required int locationId,
    String? avatar, // File path for avatar upload
  });

  /// Registers a new organization user.
  ///
  /// Returns a [Future<(AccessToken, Role)>] containing the access token and role on success.
  Future<(AccessToken accessToken, Role role)> registerOrganization({
    required String name,
    required String email,
    required String password,
    required int locationId,
    required int sectorId,
    String? bio,
    String? contactEmail,
    String? website,
    String? logo,
  });

  /// Change password for the user with given [currentPassword] and [newPassword].
  ///
  /// Returns a [Future<void>] that completes when the password change is successful.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    String? accessToken,
  });

  Future<void> forgotPassword({String email});
}
