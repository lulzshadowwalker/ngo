import 'package:flutter_test/flutter_test.dart';
import 'package:ngo/models/organization.dart';

void main() {
  group('Organization.fromLaravel', () {
    test('parses Laravel JSON API response correctly', () {
      final json = {
        "data": {
          "type": "organizations",
          "id": "1",
          "attributes": {
            "name": "Miss Abbie Gulgowski",
            "slug": "missabbiegulgowski",
            "bio": "Reiciendis odio nesciunt est aliquam quia praesentium.",
            "logo":
                "https://images.unsplash.com/photo-1562307534-a03738d2a81a?q=80&w=3174&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            "website":
                "http://www.kautzer.org/vel-maiores-commodi-velit-debitis-vero-repellat-aut-totam.html",
            "sector": "Miss Maye Schneider",
            "location": "Caylaton, Georgia",
            "createdAt": "2025-06-05T12:27:15+00:00",
            "updatedAt": "2025-06-05T12:27:15+00:00"
          },
          "relationships": {
            "sector": {
              "data": {"type": "sectors", "id": "1"}
            },
            "location": {
              "data": {"type": "locations", "id": "1"}
            },
            "posts": [],
            "organizationPreferences": [],
            "follows": []
          }
        }
      };

      final org = Organization.fromLaravel(json['data'] as Map<String, dynamic>);

      expect(org.id, "1");
      expect(org.name, "Miss Abbie Gulgowski");
      expect(org.slug, "missabbiegulgowski");
      expect(org.bio, "Reiciendis odio nesciunt est aliquam quia praesentium.");
      expect(org.logo, startsWith("https://images.unsplash.com/photo-1562307534"));
      expect(org.website, startsWith("http://www.kautzer.org/vel-maiores-commodi"));
      expect(org.sector, "Miss Maye Schneider");
      expect(org.location, "Caylaton, Georgia");
      expect(org.createdAt, DateTime.parse("2025-06-05T12:27:15+00:00"));
      expect(org.updatedAt, DateTime.parse("2025-06-05T12:27:15+00:00"));
    });

    test('throws if required fields are missing', () {
      final incompleteJson = {
        "id": "2",
        "attributes": {
          // name, slug, etc. are missing
        }
      };

      expect(
        () => Organization.fromLaravel(incompleteJson),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
