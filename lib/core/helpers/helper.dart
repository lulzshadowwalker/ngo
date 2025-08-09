import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._(); // Private constructor

  static late SharedPreferences _sharedPreferences;

  /// Initializes the SharedPreferences instance.
  static Future<void> init() async {
    debugPrint('SharedPrefHelper : init called');
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Exposes the instance if needed
  static SharedPreferences get instance => _sharedPreferences;

  /// Removes a value from SharedPreferences with given [key].
  static Future<void> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    await _sharedPreferences.remove(key);
  }

  /// Removes all keys and values in SharedPreferences.
  static Future<void> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    await _sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in SharedPreferences.
  static Future<void> setData(String key, dynamic value) async {
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");

    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else {
      debugPrint(
        "Unsupported value type for SharedPreferences: ${value.runtimeType}",
      );
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static Future<bool> getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    return _sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static Future<double> getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    return _sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static Future<int> getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    return _sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets a string value from SharedPreferences with given [key].
  static Future<String> getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : $key');
    return _sharedPreferences.getString(key) ?? '';
  }

  /// FlutterSecureStorage methods

  static const FlutterSecureStorage _flutterSecureStorage =
      FlutterSecureStorage();

  /// Saves a [value] with a [key] in FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    debugPrint(
      "FlutterSecureStorage : setSecuredString with key : $key and value : $value",
    );
    await _flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets a string value from FlutterSecureStorage with given [key].
  static Future<String> getSecuredString(String key) async {
    debugPrint('FlutterSecureStorage : getSecuredString with key : $key');
    return await _flutterSecureStorage.read(key: key) ?? '';
  }

  /// Clears all data from FlutterSecureStorage.
  static Future<void> clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    await _flutterSecureStorage.deleteAll();
  }

  /// Auth-specific helper methods
  
  /// Saves authentication data (access token and role)
  static Future<void> saveAuthData({
    required String accessToken,
    required String role,
  }) async {
    debugPrint('SharedPrefHelper : saving auth data');
    await setSecuredString('access_token', accessToken);
    await setData('user_role', role);
    await setData('is_logged_in', true);
  }

  /// Gets the saved access token
  static Future<String> getAccessToken() async {
    return await getSecuredString('access_token');
  }

  /// Gets the saved user role
  static Future<String> getUserRole() async {
    return await getString('user_role');
  }

  /// Checks if user is logged in
  static Future<bool> isLoggedIn() async {
    return await getBool('is_logged_in');
  }

  /// Clears all authentication data
  static Future<void> clearAuthData() async {
    debugPrint('SharedPrefHelper : clearing auth data');
    await _flutterSecureStorage.delete(key: 'access_token');
    await removeData('user_role');
    await removeData('is_logged_in');
  }
}
