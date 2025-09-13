import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferences.freezed.dart';

@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    required String id,
    required String language,
    required bool emailNotifications,
    required bool pushNotifications,
    required bool? profileVisibility,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserPreferences;

  factory UserPreferences.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;

    return UserPreferences(
      id: data['id'] as String,
      language: attributes['language'] as String? ?? 'en',
      emailNotifications: attributes['emailNotifications'] as bool? ?? true,
      pushNotifications: attributes['pushNotifications'] as bool? ?? true,
      profileVisibility: attributes['profileVisibility'] as bool?,
      createdAt: DateTime.parse(attributes['createdAt'] as String),
      updatedAt: DateTime.parse(attributes['updatedAt'] as String),
    );
  }
}
