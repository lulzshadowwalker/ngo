part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.followingLoaded({
    required int profileCompletion,
    required List<Post> posts,
    required List<Opportunity> opportunities,
  }) = _FollowingLoaded;
  const factory HomeState.recentLoaded({
    required List<Post> posts,
    required List<Opportunity> opportunities,
  }) = _RecentLoaded;
  const factory HomeState.error(String message) = _Error;
}
