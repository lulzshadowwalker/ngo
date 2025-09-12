import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_field.freezed.dart';

enum FormFieldType {
  text,
  textarea,
  email,
  phone,
  date,
  select,
  checkbox,
  file,
}

@freezed
abstract class FormField with _$FormField {
  const factory FormField({
    required int id,
    required FormFieldType type,
    required String label,
    String? placeholder,
    String? helpText,
    List<String>? options,
    Map<String, dynamic>? validationRules,
    required bool isRequired,
    required int sortOrder,
  }) = _FormField;

  factory FormField.fromJson(Map<String, dynamic> json) {
    return FormField(
      id: json['id'] as int,
      type: FormFieldType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => FormFieldType.text,
      ),
      label: json['label'] as String,
      placeholder: json['placeholder'] as String?,
      helpText: json['helpText'] as String?,
      options: (json['options'] as List<dynamic>?)?.cast<String>(),
      validationRules: json['validationRules'] as Map<String, dynamic>?,
      isRequired: json['isRequired'] as bool,
      sortOrder: json['sortOrder'] as int,
    );
  }
}
