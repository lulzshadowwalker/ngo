import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/features/post/data/repo/posts_repository.dart';
import 'package:ngo/features/post/logic/post_state.dart';

import '../../../core/helpers/helper.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postsRepository}) : super(PostState.initial());

  final PostsRepository postsRepository;
  List<Post>? post;
  
  Future<void> fetchAllPost({String language = 'en'}) async {
    try {
      emit(PostState.loading());
 
      final accessToken = await SharedPrefHelper.getAccessToken();

      post = await postsRepository.fetchAll(accessToken , language: language);
      log('Fetched posts: ${post?.length}');
      emit(PostState.loaded(post!));
    } catch (e) {
      log('Error fetching posts: $e');
      emit(PostState.error(e.toString()));
    }
  }

  Future<void> searchPosts({
    String query = '',
    String language = 'en',
    String? sectorId,
  }) async {
    try {
      emit(PostState.loading());
      
      post = await postsRepository.search(
        query,
        language: language,
        sectorId: sectorId,
      );
      log('Searched posts: ${post?.length}, query: "$query", sectorId: $sectorId');
      emit(PostState.loaded(post!));
    } catch (e) {
      log('Error searching posts: $e');
      emit(PostState.error(e.toString()));
    }
  }

  Future<void> fetchSinglePost({
    required String slug,
    String language = 'en',
  }) async {
    try {
      emit(PostState.loading());
      
      final accessToken = await SharedPrefHelper.getAccessToken();
      
      final singlePost = await postsRepository.fetch(
        accessToken,
        slug,
        language: language,
      );
      log('Fetched single post: ${singlePost.title}, slug: $slug');
      
      // Create a list with the single post to maintain consistency with state
      post = [singlePost];
      emit(PostState.loaded(post!));
    } catch (e) {
      log('Error fetching single post: $e');
      emit(PostState.error(e.toString()));
    }
  }




}
