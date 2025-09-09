part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.loggingIn() = _LoggingIn;
  const factory AuthState.registering() = _Registering;
  const factory AuthState.loggingOut() = _LoggingOut;
  const factory AuthState.authenticated({
    required String accessToken,
    required Role role,
  }) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.loginError(String message) = _LoginError;
  const factory AuthState.registerError(String message) = _RegisterError;
  const factory AuthState.logoutError(String message) = _LogoutError;
  const factory AuthState.forgotPasswordLoading() = _ForgotPasswordLoading;
  const factory AuthState.forgotPasswordSuccess() = _ForgotPasswordSuccess;
  const factory AuthState.forgotPasswordError(String message) = _ForgotPasswordError;
  const factory AuthState.error(String message) = _Error;
}
