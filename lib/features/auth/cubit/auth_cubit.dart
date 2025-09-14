import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/contracts/auth_repository.dart';
import '../../../core/helpers/helper.dart';
import '../../../models/role.dart';
import '../../../service_locator.dart';
import '../../user_management/cubit/user_management_cubit.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState.initial());

  /// Initialize AuthCubit and restore auth state from SharedPreferences
  /// Call this method after creating the AuthCubit instance
  /// Example:
  /// ```dart
  /// final authCubit = AuthCubit(authRepository);
  /// await authCubit.restoreAuthState();
  /// ```
  Future<void> initialize() async {
    await restoreAuthState();
  }

  /// Login with email and password
  Future<void> login({
    required String email,
    required String password,
    String? deviceToken,
  }) async {
    try {
      emit(const AuthState.loggingIn());

      final (accessToken, role) = await _authRepository.login(
        email,
        password,
        deviceToken: deviceToken,
      );

      // Save auth data to SharedPreferences
      await SharedPrefHelper.saveAuthData(
        accessToken: accessToken,
        role: role.name,
      );

  emit(AuthState.authenticated(accessToken: accessToken, role: role));
  // Save user id globally after login
  sl<UserManagementCubit>().fetchCurrentUser();
    } catch (error) {
      emit(AuthState.loginError(error.toString()));
    }
  }

  /// Register new individual user
  Future<void> registerIndividual({
    required String name,
    required String email,
    required String password,
    required int locationId,
    String? avatar,
  }) async {
    try {
      emit(const AuthState.registering());

      final (accessToken, role) = await _authRepository.registerIndividual(
        name: name,
        email: email,
        password: password,
        locationId: locationId,
        avatar: avatar,
      );

      // Save auth data to SharedPreferences
      await SharedPrefHelper.saveAuthData(
        accessToken: accessToken,
        role: role.name,
      );

  emit(AuthState.authenticated(accessToken: accessToken, role: role));
  // Save user id globally after registration
  sl<UserManagementCubit>().fetchCurrentUser();
    } catch (error) {
      emit(AuthState.registerError(error.toString()));
    }
  }

  /// Register new organization user
  Future<void> registerOrganization({
    required String name,
    required String email,
    required String password,
    required int locationId,
    required int sectorId,
    String? bio,
    String? contactEmail,
    String? website,
    String? logo,
  }) async {
    try {
      emit(const AuthState.registering());
      final (accessToken, role) = await _authRepository.registerOrganization(
        name: name,
        email: email,
        password: password,
        locationId: locationId,
        sectorId: sectorId,
        bio: bio,
        contactEmail: contactEmail,
        website: website,
        logo: logo,
      );
      await SharedPrefHelper.saveAuthData(
        accessToken: accessToken,
        role: role.name,
      );
  emit(AuthState.authenticated(accessToken: accessToken, role: role));
  // Save user id globally after registration
  sl<UserManagementCubit>().fetchCurrentUser();
    } catch (error) {
      emit(AuthState.registerError(error.toString()));
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      emit(const AuthState.loggingOut());
      // await _authRepository.logout();

      // Clear auth data from SharedPreferences
      await SharedPrefHelper.clearAuthData();

      emit(const AuthState.unauthenticated());
    } catch (error) {
      emit(AuthState.logoutError(error.toString()));
    }
  }

  /// Send forgot password email
  Future<void> forgotPassword({required String email}) async {
    try {
      emit(const AuthState.forgotPasswordLoading());

      await _authRepository.forgotPassword(email: email);

      emit(const AuthState.forgotPasswordSuccess());
    } catch (error) {
      emit(AuthState.forgotPasswordError(error.toString()));
    }
  }

  /// Change user password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      emit(const AuthState.passwordChangeLoading());
      final accessToken = await SharedPrefHelper.getAccessToken();
      // Get the current access token

      await _authRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        accessToken: accessToken,
      );

      emit(const AuthState.passwordChangeSuccess());
    } catch (e) {
      emit(
        AuthState.passwordChangeError(
          'An unexpected error occurred: ${e.toString()}',
        ),
      );
    }
  }

  /// Clear error state
  void clearError() {
    emit(const AuthState.initial());
  }

  /// Restore auth state from SharedPreferences
  Future<void> restoreAuthState() async {
    try {
      final isLoggedIn = await SharedPrefHelper.isLoggedIn();

      if (isLoggedIn) {
        final accessToken = await SharedPrefHelper.getAccessToken();
        final roleString = await SharedPrefHelper.getUserRole();

        if (accessToken.isNotEmpty && roleString.isNotEmpty) {
          final role = Role.from(roleString);
          emit(AuthState.authenticated(accessToken: accessToken, role: role));
        } else {
          // Clear invalid auth data
          await SharedPrefHelper.clearAuthData();
          emit(const AuthState.unauthenticated());
        }
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (error) {
      // Clear invalid auth data and set unauthenticated state
      await SharedPrefHelper.clearAuthData();
      emit(const AuthState.unauthenticated());
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => state is _Authenticated;

  /// Check if any operation is in progress
  bool get isLoading =>
      state is _Loading ||
      state is _LoggingIn ||
      state is _Registering ||
      state is _LoggingOut ||
      state is _ForgotPasswordLoading ||
      state is _PasswordChangeLoading;

  /// Get current access token if authenticated
  String? get accessToken {
    final currentState = state;
    if (currentState is _Authenticated) {
      return currentState.accessToken;
    }
    return null;
  }

  /// Get current user role if authenticated
  Role? get userRole {
    final currentState = state;
    if (currentState is _Authenticated) {
      return currentState.role;
    }
    return null;
  }
}
