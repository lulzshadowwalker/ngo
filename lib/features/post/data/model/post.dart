import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/models/organization.dart';
import 'package:ngo/models/sectors.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String id,
    required String title,
    required String slug,
    required String content,
    required String cover,
    required Organization? organization,
    required Sector? sector,
    required DateTime createdAt,
    required String createdAtReadable,
    required DateTime updatedAt,
  }) = _Post;

  factory Post.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;
    final includes = <String, dynamic>{};
    if (data['includes'] is Map<String, dynamic>) {
      includes.addAll(data['includes'] as Map<String, dynamic>);
    }

    return Post(
      id: data['id'] as String,
      slug: attributes['slug'] as String,
      createdAt: DateTime.parse(attributes['createdAt'] as String),
      updatedAt: DateTime.parse(attributes['updatedAt'] as String),
      title: attributes['title'],
      content: attributes['content'],
      cover: attributes['cover'],
      createdAtReadable: attributes['createdAtReadable'],
      organization: includes['organization'] == null
          ? null
          : Organization.fromLaravel(includes['organization']),
      sector: includes['sector'] == null
          ? null
          : Sector.fromLaravel(includes['sector']),
    );
  }
}
