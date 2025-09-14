import 'package:freezed_annotation/freezed_annotation.dart';

part 'sectors.freezed.dart';

@freezed
abstract class Sector with _$Sector {
  const factory Sector({required String id, required String name}) = _Sector;

  factory Sector.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;

    return Sector(id: data['id'] as String, name: attributes['name'] as String);
  }

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(id: json['id'].toString(), name: json['name'] as String);
  }
}
