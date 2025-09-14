import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/models/form_field.dart';

part 'application_form.freezed.dart';

@freezed
abstract class ApplicationForm with _$ApplicationForm {
  const factory ApplicationForm({
    required int id,
    required String title,
    String? description,
    required bool isActive,
    required List<FormField> formFields,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ApplicationForm;

  factory ApplicationForm.fromJson(Map<String, dynamic> json) {
    return ApplicationForm(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      formFields: (json['formFields'] as List<dynamic>? ?? [])
          .map((field) => FormField.fromJson(field as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }
}
