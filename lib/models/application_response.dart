import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/models/form_field.dart';

part 'application_response.freezed.dart';

@freezed
abstract class ApplicationResponse with _$ApplicationResponse {
  const factory ApplicationResponse({
    required int id,
    required int formFieldId,
    required String value,
    required FormField formField,
  }) = _ApplicationResponse;

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationResponse(
      id: json['id'] as int,
      formFieldId: json['formFieldId'] as int,
      value: json['value'] as String,
      formField: FormField.fromJson(json['formField'] as Map<String, dynamic>),
    );
  }
}

extension ApplicationResponseExtension on ApplicationResponse {
  Map<String, dynamic> toSubmissionJson() {
    return {
      'formFieldId': formFieldId,
      'value': value,
    };
  }
}
