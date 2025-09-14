import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/feed_repository.dart';
import 'package:ngo/core/helpers/helper.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/models/opportunity.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FeedRepository _feedRepository;

  HomeCubit(this._feedRepository) : super(const HomeState.initial());

  Future<void> loadFollowingFeed({String language = 'en'}) async {
    try {
      emit(const HomeState.loading());

      final accessToken = await SharedPrefHelper.getAccessToken();
      log("Loading following feed with language: $language , $accessToken");

      final result = await _feedRepository.following(
        accessToken,
        language: language,
      );

      log(
        "Following feed loaded: ${result.$2.length} posts, ${result.$3.length} opportunities",
      );

      emit(
        HomeState.followingLoaded(
          profileCompletion: result.$1,
          posts: result.$2,
          opportunities: result.$3,
        ),
      );
    } catch (error) {
      log("Error loading following feed: $error");
      emit(HomeState.error(error.toString()));
    }
  }

  Future<void> loadRecentFeed({String language = 'en'}) async {
    try {
      emit(const HomeState.loading());

      log("Loading recent feed with language: $language");

      final result = await _feedRepository.recent(language: language);

      log(
        "Recent feed loaded: ${result.$1.length} posts, ${result.$2.length} opportunities",
      );

      emit(HomeState.recentLoaded(posts: result.$1, opportunities: result.$2));
    } catch (error) {
      log("Error loading recent feed: $error");
      emit(HomeState.error(error.toString()));
    }
  }

  Future<void> refreshFeed({
    required bool isFollowing,
    String language = 'en',
  }) async {
    if (isFollowing) {
      await loadFollowingFeed(language: language);
    } else {
      await loadRecentFeed(language: language);
    }
  }
}
