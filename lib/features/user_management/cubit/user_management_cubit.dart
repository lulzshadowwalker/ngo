import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/user_management_regpository.dart';
import 'package:ngo/models/user.dart';
import 'package:ngo/models/user_preferences.dart';

import '../../../core/helpers/helper.dart';

part 'user_management_cubit.freezed.dart';
part 'user_management_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  final UserManagementRepository _repository;

  UserManagementCubit(this._repository)
    : super(const UserManagementState.initial());

  Future<void> fetchCurrentUser() async {
    final accessToken = await SharedPrefHelper.getAccessToken();

    try {
      emit(const UserManagementState.loading());

      final user = await _repository.getCurrentUser(accessToken);
      // Save user id for app-wide access
      log("save user id for app-wide access $user");
      await SharedPrefHelper.setData('user_id', user.id);
      emit(UserManagementState.loaded(user: user));
    } catch (error) {
      emit(UserManagementState.error(error.toString()));
    }
  }

  Future<void> fetchUserPreferences() async {
    final accessToken = await SharedPrefHelper.getAccessToken();
    try {
      emit(const UserManagementState.loading());

      final preferences = await _repository.getUserPreferences(accessToken);

      emit(UserManagementState.loaded(preferences: preferences));
    } catch (error) {
      emit(UserManagementState.error(error.toString()));
    }
  }

  Future<void> updatePreferences(Map<String, dynamic> preferences) async {
    try {
      final accessToken = await SharedPrefHelper.getAccessToken();
      log("Updating preferences with data: $preferences");
      emit(const UserManagementState.loading());

      final updatedPreferences = await _repository.updateUserPreferences(
        accessToken,
        preferences,
      );

      log("Updated preferences received: ${updatedPreferences.toString()}");
      emit(UserManagementState.loaded(preferences: updatedPreferences));
    } catch (error) {
      log("Error updating preferences: $error");
      // If it's a profileVisibility validation error, provide specific feedback
      if (error.toString().contains('profile visibility is invalid')) {
        emit(
          UserManagementState.error(
            'Profile visibility setting not supported. Please contact support.',
          ),
        );
      } else {
        emit(
          UserManagementState.error(
            'Failed to update preferences: ${error.toString()}',
          ),
        );
      }
    }
  }

  Future<void> fetchUserData() async {
    final accessToken = await SharedPrefHelper.getAccessToken();
    try {
      emit(const UserManagementState.loading());

      final user = await _repository.getCurrentUser(accessToken);
      final preferences = await _repository.getUserPreferences(accessToken);

      emit(UserManagementState.loaded(user: user, preferences: preferences));
    } catch (error) {
      emit(UserManagementState.error(error.toString()));
    }
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? bio,
    String? birthdate,
    String? website,
    String? contactEmail,
    int? locationId,
    List<int>? skillIds,
    int? sectorId,
    File? avatarFile,
  }) async {
    final accessToken = await SharedPrefHelper.getAccessToken();

    try {
      emit(const UserManagementState.loading());

      final profileData = <String, dynamic>{};

      if (name != null) profileData['name'] = name;
      if (email != null) profileData['email'] = email;
      if (bio != null) profileData['bio'] = bio;
      if (birthdate != null) profileData['birthdate'] = birthdate;
      if (website != null) profileData['website'] = website;
      if (contactEmail != null) profileData['contactEmail'] = contactEmail;
      if (locationId != null) profileData['locationId'] = locationId;
      if (skillIds != null) profileData['skillIds'] = skillIds;
      if (sectorId != null) profileData['sectorId'] = sectorId;

      final updatedUser = await _repository.updateProfile(
        accessToken,
        profileData,
        avatarFile: avatarFile,
      );

      emit(UserManagementState.loaded(user: updatedUser));
    } catch (error) {
      log("Error updating profile: $error");
      emit(
        UserManagementState.error(
          'Failed to update profile: ${error.toString()}',
        ),
      );
    }
  }
}
