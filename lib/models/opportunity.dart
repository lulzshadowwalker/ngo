import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/models/application_form.dart';
import 'package:ngo/models/organization.dart';
import 'package:ngo/models/program.dart';
import 'package:ngo/models/sectors.dart';

part 'opportunity.freezed.dart';

enum OpportunityStatus {
  active,
  inactive,
  expired,
}

@freezed
abstract class Opportunity with _$Opportunity {
  const factory Opportunity({
    required String id,
    required String title,
    required String description,
    String? aboutTheRole,
    required int duration,
    required DateTime expiryDate,
    String? latitude,
    String? longitude,
    String? locationDescription,
    required List<String> tags, // Changed from List<String> to String
    required List<String> keyResponsibilities,
    required List<String> requiredSkills,
    required List<String> timeCommitment,
    required List<String> benefits,
    String? extra,
    required bool isFeatured,
    required OpportunityStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Organization organization,
    required Sector sector,
    required int locationId, // Changed from Location object to int
    int? programId, // Added programId field
    Program? program,
    ApplicationForm? applicationForm,
  }) = _Opportunity;

  // Helper method to get tags as a list


  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      aboutTheRole: json['aboutTheRole'] as String?,
      duration: json['duration'] as int,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      locationDescription: json['locationDescription'] as String?,
      tags: (json['tags'] as List<dynamic>).cast<String>(), // Changed to handle string instead of list
      keyResponsibilities: (json['keyResponsibilities'] as List<dynamic>).cast<String>(),
      requiredSkills: (json['requiredSkills'] as List<dynamic>).cast<String>(),
      timeCommitment: (json['timeCommitment'] as List<dynamic>).cast<String>(),
      benefits: (json['benefits'] as List<dynamic>).cast<String>(),
      extra: json['extra'] as String?,
      isFeatured: json['isFeatured'] as bool,
      status: OpportunityStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OpportunityStatus.active,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      organization: Organization.fromJson(json['organization'] as Map<String, dynamic>),
      sector: Sector.fromJson(json['sector'] as Map<String, dynamic>),
      locationId: json['locationId'] as int, // Updated to handle int instead of Location object
      programId: json['programId'] as int?, // Added programId handling
      program: json['program'] != null 
          ? Program.fromJson(json['program'] as Map<String, dynamic>)
          : null,
      applicationForm: json['applicationForm'] != null 
          ? ApplicationForm.fromJson(json['applicationForm'] as Map<String, dynamic>)
          : null,
    );
  }
}
