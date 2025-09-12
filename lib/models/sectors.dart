

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sectors.freezed.dart';

@freezed 
abstract class Sector with _$Sector {
  const factory Sector({
    required String id,
    required String name,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Sector;

  factory Sector.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;

    return Sector(
      id: data['id'] as String,
      name: attributes['name'] as String,
      description: attributes['description'] as String,
      createdAt: DateTime.parse(attributes['createdAt'] as String),
      updatedAt: DateTime.parse(attributes['updatedAt'] as String),
    );
  }

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json['id'].toString(),
      name: json['name'] as String,
      description: '', // Default since not provided in API response
      createdAt: DateTime.now(), // Default since not provided
      updatedAt: DateTime.now(),
    );
  }
}
