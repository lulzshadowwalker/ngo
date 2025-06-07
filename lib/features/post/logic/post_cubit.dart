import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/features/post/data/repo/posts_repository.dart';
import 'package:ngo/features/post/logic/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postsRepository}) : super(PostState.initial());

  final PostsRepository postsRepository;
  List<Post>? post;
  Future<void> fetchAllPost({String language = 'en'}) async {
    try {
      emit(PostState.loading());

      post = await postsRepository.fetchAll(language: language);
      log('Fetched posts: ${post?.length}');
      emit(PostState.loaded(post!));
    } catch (e) {
      emit(PostState.error(e.toString()));
    }
  }
}
