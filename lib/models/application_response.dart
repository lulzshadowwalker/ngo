import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/models/form_field.dart';

part 'application_response.freezed.dart';

@freezed
abstract class ApplicationResponse with _$ApplicationResponse {
  const factory ApplicationResponse({
    required String id,
    required int formFieldId,
    required String value,
    required FormField formField,
  }) = _ApplicationResponse;

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationResponse(
      id: json['id'] as String,
      formFieldId: json['formFieldId'] as int,
      value: json['value'] as String,
      formField: FormField.fromJson(json['formField'] as Map<String, dynamic>),
    );
  }
}

extension ApplicationResponseExtension on ApplicationResponse {
  Map<String, dynamic> toSubmissionJson() {
    return {'form_field_id': formFieldId, 'value': value};
  }
}
