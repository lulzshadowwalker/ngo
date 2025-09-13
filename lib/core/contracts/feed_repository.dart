import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/models/opportunity.dart';

typedef FollowingFeed = (
  int profileCompletion,
  List<Post> posts,
  List<Opportunity> opportunities,
);

typedef RecentFeed = (List<Post> posts, List<Opportunity> opportunities);

abstract interface class FeedRepository {
  Future<FollowingFeed> following(String accessToken, {String language});
  Future<RecentFeed> recent({String language});
}
