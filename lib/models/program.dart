import 'package:freezed_annotation/freezed_annotation.dart';

part 'program.freezed.dart';

@freezed
abstract class Program with _$Program {
  const factory Program({
    required int id,
    required String title,
    required String? description,
    // required DateTime createdAt,
    // required DateTime updatedAt,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      // createdAt: DateTime.parse(json['createdAt'] as String),
      // updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
