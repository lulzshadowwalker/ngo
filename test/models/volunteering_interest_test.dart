import 'package:flutter_test/flutter_test.dart';
import 'package:ngo/models/volunteering_interest.dart';

void main() {
  group('VolunteeringInterest.fromLaravel', () {
    test('parses Laravel JSON API response correctly', () {
      // Example Laravel JSON API response
      final json = {
        "data": {
          "type": "volunteeringi-interests",
          "id": "1",
          "attributes": {
            "name": "Paris Rodriguez",
            "createdAt": "2025-06-05T12:28:48+00:00",
            "updatedAt": "2025-06-05T12:28:48+00:00",
          },
          "relationships": {},
        },
      };

      final volunteeringInterest = VolunteeringInterest.fromLaravel(json['data'] as Map<String, dynamic>);

      expect(volunteeringInterest.id, "1");
      expect(volunteeringInterest.name, "Paris Rodriguez");
    });

    test('throws if required fields are missing', () {
      final incompleteJson = {
        "id": "2",
        "attributes": {
          // name is missing
        },
      };

      expect(
        () => VolunteeringInterest.fromLaravel(incompleteJson),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
