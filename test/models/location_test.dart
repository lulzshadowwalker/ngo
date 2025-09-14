import 'package:flutter_test/flutter_test.dart';
import 'package:ngo/models/location.dart';

void main() {
  group('Location.fromLaravel', () {
    test('parses Laravel JSON API response correctly', () {
      // Example Laravel JSON API response
      final json = {
        "data": {
          "type": "locations",
          "id": "1",
          "attributes": {
            "city": "Caylaton",
            "country": "Georgia",
            "createdAt": "2025-06-05T12:27:13+00:00",
            "updatedAt": "2025-06-05T12:27:13+00:00",
          },
          "relationships": {"individuals": [], "organizations": []},
        },
      };

      final location = Location.fromLaravel(
        json['data'] as Map<String, dynamic>,
      );

      expect(location.id, "1");
      expect(location.city, "Caylaton");
      expect(location.country, "Georgia");
    });

    test('throws if required fields are missing', () {
      final incompleteJson = {
        "id": "2",
        "attributes": {
          // city and country are missing
        },
      };

      expect(
        () => Location.fromLaravel(incompleteJson),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
