import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/features/post/data/model/post.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = Loading;
  const factory PostState.loaded(List<Post> posts) = Loaded;
  const factory PostState.loadedSinglePost(Post post) = LoadedSinglePost;
  const factory PostState.error(String message) = Error;
}
