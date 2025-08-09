import 'package:ngo/features/post/data/model/post.dart';

abstract interface class PostsRepository {
  Future<List<Post>> fetchAll(String accessToken,{String language});
  Future<Post> fetch(String accessToken, String slug, {String language});
}
