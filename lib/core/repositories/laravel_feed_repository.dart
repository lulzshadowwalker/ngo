import 'dart:developer';

import 'package:ngo/core/contracts/feed_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/models/opportunity.dart';

final class LaravelFeedRepository extends LaravelRepository
    implements FeedRepository {
  @override
  Future<FollowingFeed> following(
    String accessToken, {
    String language = 'en',
  }) async {
    log(
      'LaravelFeedRepository: Fetching following feed with language: $language',
    );

    final response = await get(
      '/v1/feeds/following',
      headers: {
        'Accept-Language': language,
        'Authorization': 'Bearer $accessToken',
      },
    );

    return (
          profileCompletion: response['profileCompletion'] as int,
          posts: (response['posts'] as List<dynamic>)
              .map((item) => Post.fromLaravel(item as Map<String, dynamic>))
              .toList()
              .cast<Post>(),
          opportunities: (response['opportunities'] as List<dynamic>)
              .map(
                (item) => Opportunity.fromLaravel(item as Map<String, dynamic>),
              )
              .toList()
              .cast<Opportunity>(),
        )
        as FollowingFeed;
  }

  @override
  Future<RecentFeed> recent({String language = 'en'}) async {
    log('LaravelFeedRepository: Fetching recent feed with language: $language');
    final response = await get(
      '/v1/feeds/recent',
      headers: {'Accept-Language': language},
    );
    return (
          posts: (response['posts'] as List<dynamic>)
              .map((item) => Post.fromLaravel(item as Map<String, dynamic>))
              .toList()
              .cast<Post>(),
          opportunities: (response['opportunities'] as List<dynamic>)
              .map(
                (item) => Opportunity.fromLaravel(item as Map<String, dynamic>),
              )
              .toList()
              .cast<Opportunity>(),
        )
        as RecentFeed;
  }
}
