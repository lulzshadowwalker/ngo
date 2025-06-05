import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/models/organization.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String id,
    required String title,
    required String content,
    required String cover,
    required Organization? organization,
    required DateTime createdAt,
    required String createdAtReadable,
    required DateTime updatedAt,
  }) = _Post;

  factory Post.fromLaravel(Map<String, dynamic> data) {
    final attributes = data['attributes'] as Map<String, dynamic>;
    final includes = data['includes'] as Map<String, dynamic>;

    return Post(
      id: data['id'] as String,
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
      title: attributes['title'],
      content: attributes['content'],
      cover: attributes['cover'],
      createdAtReadable: attributes['createdAtReadable'],
      organization: includes['organization'] == null
          ? null
          : Organization.fromLaravel(includes['organization']),
    );
  }
}
