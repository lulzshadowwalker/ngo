import 'package:freezed_annotation/freezed_annotation.dart';

import 'program.dart'; // Import the Program model

part 'organization.freezed.dart';

@freezed
abstract class Organization with _$Organization {
  const factory Organization({
    required String id,
    required String name,
    required String slug,
    required String logo,
    required String sector,
    required String location,
    required String? bio,
    required String? website,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isFollowed,
    required List<Program> programs, // Added programs list
  }) = _Organization;

  factory Organization.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;
    
    // Parse programs if they exist in the response
List<Program> programsList = [];
    if (data['includes'] != null && data['includes']['programs'] != null) {
      final programsData = data['includes']['programs'] as List;
      programsList = programsData
          .map((programData) {
            final programAttributes = programData['attributes'] as Map<String, dynamic>;
            return Program.fromJson({
              'id': programData['id'],
              'title': programAttributes['title'],
              'description': programAttributes['description'],
              'cover': programAttributes['cover'],
              // Add other fields if needed
            });
          })
          .toList();
    }

    return Organization(
      id: data['id'] as String,
      name: attributes['name'] as String,
      slug: attributes['slug'] as String,
      logo: attributes['logo'] as String,
      sector: attributes['sector'] as String,
      location: attributes['location'] as String,
      bio: attributes['bio'] as String?,
      website: attributes['website'] as String?,
      createdAt: DateTime.parse(attributes['createdAt'] as String),
      updatedAt: DateTime.parse(attributes['updatedAt'] as String),
      isFollowed: attributes['following'] as bool? ?? false,
      programs: programsList,
    );
  }

  factory Organization.fromJson(Map<String, dynamic> json) {
    // Parse programs if they exist in the response
    List<Program> programsList = [];
    if (json['programs'] != null) {
      final programsData = json['programs'] as List;
      programsList = programsData
          .map((programData) => Program.fromJson(programData as Map<String, dynamic>))
          .toList();
    }

    return Organization(
      id: json['id'].toString(),
      name: json['name'] as String,
      slug: '', // Default values for API response that doesn't include these fields
      logo: '',
      sector: '',
      location: '',
      bio: null,
      website: null,
      createdAt: DateTime.now(), // Default since not provided in API
      updatedAt: DateTime.now(),
      isFollowed: false,
      programs: programsList,
    );
  }
}
