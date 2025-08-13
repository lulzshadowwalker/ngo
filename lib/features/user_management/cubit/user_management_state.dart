part of 'user_management_cubit.dart';

@freezed
class UserManagementState with _$UserManagementState {
  const factory UserManagementState.initial() = _Initial;
  const factory UserManagementState.loading() = _Loading;
  const factory UserManagementState.loaded({
    User? user,
    UserPreferences? preferences,
  }) = _Loaded;
  const factory UserManagementState.error(String message) = _Error;
}
