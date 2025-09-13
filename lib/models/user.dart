import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/models/location.dart';
import 'package:ngo/models/organization.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required String? avatar,
    required String? bio,
    required DateTime? birthdate,
    Location? location,
    List<String>? skills,
    List<Organization>? following,
  }) = _User;

  factory User.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;
    final includes = data['includes'] as Map<String, dynamic>?;

    Location? location;
    if (includes?['location'] != null) {
      location = Location.fromLaravel(includes!['location'] as Map<String, dynamic>);
    }

    List<String>? skills;
    if (includes?['skills'] != null) {
      final skillsList = includes!['skills'] as List<dynamic>;
      skills = skillsList.map((skill) => skill.toString()).toList();
    }

    List<Organization>? following;
    if (includes?['following'] != null) {
      final followingList = includes!['following'] as List<dynamic>;
      following = followingList
          .map((org) => Organization.fromLaravel(org as Map<String, dynamic>))
          .toList();
    }

    return User(
      id: data['id'] as String,
      name: attributes['name'] as String? ?? '',
      email: attributes['email'] as String? ?? '',
      avatar: attributes['avatar'] as String?,
      bio: attributes['bio'] as String?,
      birthdate: attributes['birthdate'] != null
          ? DateTime.parse(attributes['birthdate'] as String)
          : null,
      location: location,
      skills: skills,
      following: following,
    );
  }
}
