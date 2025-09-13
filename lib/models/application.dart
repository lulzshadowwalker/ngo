import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/models/application_response.dart';
import 'package:ngo/models/opportunity.dart';

part 'application.freezed.dart';

enum ApplicationStatus { pending, approved, rejected }

@freezed
abstract class Application with _$Application {
  const factory Application({
    required int id,
    required int applicationFormId,
    required int userId,
    required int opportunityId,
    required ApplicationStatus status,
    required DateTime submittedAt,
    DateTime? reviewedAt,
    String? reviewerNotes,
    required Opportunity opportunity,
    required List<ApplicationResponse> responses,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] as int,
      applicationFormId: json['applicationFormId'] as int,
      userId: json['userId'] as int,
      opportunityId: json['opportunityId'] as int,
      status: ApplicationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ApplicationStatus.pending,
      ),
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.parse(json['reviewedAt'] as String)
          : null,
      reviewerNotes: json['reviewerNotes'] as String?,
      opportunity: Opportunity.fromLaravel(
        json['opportunity'] as Map<String, dynamic>,
      ),
      responses: (json['responses'] as List<dynamic>)
          .map(
            (response) =>
                ApplicationResponse.fromJson(response as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
