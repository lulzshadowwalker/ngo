import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';

@freezed
abstract class Skill with _$Skill {
  const factory Skill({required String id, required String name}) = _Skill;

  factory Skill.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;

    return Skill(id: data['id'] as String, name: attributes['name'] as String);
  }
}
