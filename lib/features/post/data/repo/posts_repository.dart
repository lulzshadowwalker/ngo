import 'package:ngo/features/post/data/model/post.dart';

abstract interface class PostsRepository {
  Future<List<Post>> fetchAll({String language});
  Future<Post> fetch(String slug, {String language});
}
