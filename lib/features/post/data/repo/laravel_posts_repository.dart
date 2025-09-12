import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/features/post/data/repo/posts_repository.dart';

final class LaravelPostsRepository extends LaravelRepository
    implements PostsRepository {
  @override
  Future<Post> fetch(
    String accessToken,
    String slug, {
    String language = 'en',
  }) async {
    final response = await get(
      '/v1/posts/$slug?include=organization,comments,likes,sector',
      headers: {'Accept-Language': language},
    );
    // Expecting: { "data": { ... } }
    final data = response['data'] as Map<String, dynamic>;
    return Post.fromLaravel(data);
  }

  @override
  Future<List<Post>> fetchAll(
    String accessToken, {
    String language = 'en',
  }) async {
    final response = await get(
      '/v1/posts?include=organization,comments,likes,sector',
      headers: {'Accept-Language': language},
    );

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Post.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Post>> search(
    String query, {
    String language = 'en',
    String? sectorId,
  }) {
    final Map<String, String> params = {'query': query};
    if (sectorId != null) {
      params['sector'] = sectorId;
    }
    final queryString = Uri(queryParameters: params).query;
    return get(
      '/v1/posts/search${queryString.isNotEmpty ? '?$queryString' : ''}',
      headers: {'Accept-Language': language},
    ).then((response) {
      final data = response['data'] as List<dynamic>;
      return data
          .map((item) => Post.fromLaravel(item as Map<String, dynamic>))
          .toList();
    });
  }
}
