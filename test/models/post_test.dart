import 'package:flutter_test/flutter_test.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/models/organization.dart';

void main() {
  group('Post.fromLaravel', () {
    test('parses Laravel JSON API response with includes as object', () {
      final json = {
        "data": {
          "type": "posts",
          "id": "1",
          "attributes": {
            "title": "Deserunt voluptates necessitatibus atque consequatur.",
            "slug": "deserunt-voluptates-necessitatibus-atque-consequatur",
            "cover":
                "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHZvbHVudGVlcnxlbnwwfHwwfHx8MA%3D%3D",
            "likeCount": 4,
            "commentCount": 2,
            "content":
                "Reprehenderit voluptatum et sapiente magni. Sint vel voluptas iure consequatur eveniet voluptatibus itaque. Praesentium omnis voluptatum omnis enim. Optio asperiores consectetur voluptatibus enim et aliquam placeat.\n\nIn sapiente qui quae quis esse nobis voluptate. Perferendis maiores ratione dolore labore ducimus consectetur. Quis illum eos nostrum sed dicta dolor veniam. Occaecati assumenda sed illo laudantium itaque architecto. Numquam omnis impedit aut vel.\n\nSunt illum et itaque animi. Molestias eos repudiandae ea omnis odit voluptates ea earum. Quia et tenetur provident laborum. Ipsum hic provident nisi fuga deserunt dolores sunt.",
            "createdAt": "2025-06-05T12:27:15+00:00",
            "createdAtReadable": "1 hour ago",
            "updatedAt": "2025-06-05T12:27:15+00:00",
          },
          "relationships": {
            "organization": {
              "data": {"type": "organizations", "id": "1"},
            },
            "comments": {
              "data": [
                {"type": "comments", "id": "1"},
                {"type": "comments", "id": "2"},
              ],
            },
            "likes": {
              "data": [
                {"type": "likes", "id": "1"},
                {"type": "likes", "id": "2"},
                {"type": "likes", "id": "3"},
                {"type": "likes", "id": "4"},
              ],
            },
          },
          "includes": {
            "organization": {
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
                "updatedAt": "2025-06-05T12:27:15+00:00",
              },
              "relationships": {
                "sector": {
                  "data": {"type": "sectors", "id": "1"},
                },
                "location": {
                  "data": {"type": "locations", "id": "1"},
                },
                "posts": [],
                "organizationPreferences": [],
                "follows": [],
              },
            },
            "comments": [
              {
                "type": "comments",
                "id": "1",
                "attributes": {
                  "content": "Nobis qui voluptatibus sit nulla quis.",
                  "createdAt": "2025-06-05T12:27:16+00:00",
                  "createdAtReadable": "1 hour ago",
                  "updatedAt": "2025-06-05T12:27:16.000000Z",
                },
                "relationships": {
                  "user": {
                    "data": {"type": "users", "id": "11"},
                  },
                },
                "includes": {},
              },
              {
                "type": "comments",
                "id": "2",
                "attributes": {
                  "content": "Qui rem aut saepe voluptas consequatur.",
                  "createdAt": "2025-06-05T12:27:16+00:00",
                  "createdAtReadable": "1 hour ago",
                  "updatedAt": "2025-06-05T12:27:16.000000Z",
                },
                "relationships": {
                  "user": {
                    "data": {"type": "users", "id": "12"},
                  },
                },
                "includes": {},
              },
            ],
            "likes": [
              {
                "type": "likes",
                "id": "1",
                "attributes": {
                  "createdAt": "2025-06-05T12:27:17+00:00",
                  "updatedAt": "2025-06-05T12:27:17+00:00",
                },
              },
              {
                "type": "likes",
                "id": "2",
                "attributes": {
                  "createdAt": "2025-06-05T12:27:18+00:00",
                  "updatedAt": "2025-06-05T12:27:18+00:00",
                },
              },
              {
                "type": "likes",
                "id": "3",
                "attributes": {
                  "createdAt": "2025-06-05T12:27:18+00:00",
                  "updatedAt": "2025-06-05T12:27:18+00:00",
                },
              },
              {
                "type": "likes",
                "id": "4",
                "attributes": {
                  "createdAt": "2025-06-05T12:27:18+00:00",
                  "updatedAt": "2025-06-05T12:27:18+00:00",
                },
              },
            ],
          },
        },
      };

      final post = Post.fromLaravel(json['data'] as Map<String, dynamic>);

      expect(post.id, "1");
      expect(
        post.title,
        "Deserunt voluptates necessitatibus atque consequatur.",
      );
      expect(post.slug, "deserunt-voluptates-necessitatibus-atque-consequatur");
      expect(
        post.cover,
        startsWith("https://images.unsplash.com/photo-1488521787991"),
      );
      expect(
        post.content,
        contains("Reprehenderit voluptatum et sapiente magni"),
      );
      expect(post.createdAtReadable, "1 hour ago");
      expect(post.organization, isA<Organization>());
      expect(post.organization?.id, "1");
      expect(post.organization?.name, "Miss Abbie Gulgowski");
    });

    test('parses when includes is an empty object', () {
      final json = {
        "data": {
          "type": "posts",
          "id": "2",
          "attributes": {
            "title": "Test Post",
            "slug": "test-post",
            "cover": "cover.jpg",
            "likeCount": 0,
            "commentCount": 0,
            "content": "Test content",
            "createdAt": "2025-06-05T12:27:15+00:00",
            "createdAtReadable": "now",
            "updatedAt": "2025-06-05T12:27:15+00:00",
          },
          "relationships": {},
          "includes": {},
        },
      };

      final post = Post.fromLaravel(json['data'] as Map<String, dynamic>);
      expect(post.id, "2");
      expect(post.title, "Test Post");
      expect(post.organization, isNull);
    });

    test('parses when includes is an array (should ignore)', () {
      final json = {
        "data": {
          "type": "posts",
          "id": "3",
          "attributes": {
            "title": "Test Post 2",
            "slug": "test-post-2",
            "cover": "cover2.jpg",
            "likeCount": 0,
            "commentCount": 0,
            "content": "Test content 2",
            "createdAt": "2025-06-05T12:27:15+00:00",
            "createdAtReadable": "now",
            "updatedAt": "2025-06-05T12:27:15+00:00",
          },
          "relationships": {},
          "includes": [],
        },
      };

      final post = Post.fromLaravel(json['data'] as Map<String, dynamic>);
      expect(post.id, "3");
      expect(post.title, "Test Post 2");
      expect(post.organization, isNull);
    });
  });
}
