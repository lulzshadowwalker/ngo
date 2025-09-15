import 'package:freezed_annotation/freezed_annotation.dart';

part 'volunteering_interest.freezed.dart';

@freezed
abstract class VolunteeringInterest with _$VolunteeringInterest {
  const factory VolunteeringInterest({required String id, required String name}) = _VolunteeringInterest;

  factory VolunteeringInterest.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;

    return VolunteeringInterest(id: data['id'] as String, name: attributes['name'] as String);
  }
}
