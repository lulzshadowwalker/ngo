import 'package:ngo/models/user.dart';
import 'package:ngo/models/user_preferences.dart';
import 'dart:io';

abstract interface class UserManagementRepository {
  Future<User> getCurrentUser(String accessToken);
  Future<UserPreferences> getUserPreferences(String accessToken);
  Future<UserPreferences> updateUserPreferences(
    String accessToken,
    Map<String, dynamic> preferences,
  );
  Future<User> updateProfile(
    String accessToken,
    Map<String, dynamic> profileData, {
    File? avatarFile,
  });
}
