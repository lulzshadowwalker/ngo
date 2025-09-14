import 'package:flutter_test/flutter_test.dart';
import 'package:ngo/models/skill.dart';

void main() {
  group('Skill.fromLaravel', () {
    test('parses Laravel JSON API response correctly', () {
      // Example Laravel JSON API response
      final json = {
        "data": {
          "type": "skills",
          "id": "1",
          "attributes": {
            "name": "Paris Rodriguez",
            "createdAt": "2025-06-05T12:28:48+00:00",
            "updatedAt": "2025-06-05T12:28:48+00:00",
          },
          "relationships": {},
        },
      };

      final skill = Skill.fromLaravel(json['data'] as Map<String, dynamic>);

      expect(skill.id, "1");
      expect(skill.name, "Paris Rodriguez");
    });

    test('throws if required fields are missing', () {
      final incompleteJson = {
        "id": "2",
        "attributes": {
          // name is missing
        },
      };

      expect(
        () => Skill.fromLaravel(incompleteJson),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
