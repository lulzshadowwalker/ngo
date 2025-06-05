import 'package:ngo/core/contracts/posts_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/post.dart';

final class LaravelPostsRepository extends LaravelRepository
    implements PostsRepository {
  @override
  Future<Post> fetch(String slug, {String language = 'en'}) async {
    final response = await get('/$language/posts/$slug');
    // Expecting: { "data": { ... } }
    final data = response['data'] as Map<String, dynamic>;
    return Post.fromLaravel(data);
  }

  @override
  Future<List<Post>> fetchAll({String language = 'en'}) async {
    final response = await get('/$language/posts');

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Post.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }
}
