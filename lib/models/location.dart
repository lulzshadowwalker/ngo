import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';

@freezed
abstract class Location with _$Location {
  const factory Location({
    required String id,
    required String city,
    required String country,
  }) = _Location;

  factory Location.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;

    return Location(
      id: data['id'] as String,
      city: attributes['city'] as String,
      country: attributes['country'] as String,
    );
  }
}
