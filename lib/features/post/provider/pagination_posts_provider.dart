import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/post/data/logic/post.dart';
import 'package:template/features/post/data/model/error_model.dart';
import 'package:template/features/post/data/model/pagination.dart';
import 'package:template/features/post/data/model/post_model.dart';
import 'package:template/features/post/error/exsapation/exception.dart';

final paginationPostsController =
    StateNotifierProvider<PaginationPostsProvider, Pagination>(
        (ref) => PaginationPostsProvider());

class PaginationPostsProvider extends StateNotifier<Pagination> {
  int _maxlimt = 10;

  PaginationPostsProvider()
      : super(Pagination(
            hasMore: true, isLoading: false, isError: false, posts: [])) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    if (!state.hasMore || state.isLoading) {
      return;
    }
    try {
      state = state.copyWith(isLoading: true);
      final List<PostModel> response = await Post().getPostsFromApi(_maxlimt);
      final List<PostModel> updatedPosts = List<PostModel>.from(state.posts)
        ..addAll(response);
      _maxlimt += 5;

      state = state.copyWith(
        isLoading: false,
        hasMore: response.isNotEmpty,
        posts: updatedPosts,
      );
    } on ServerException catch (error) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorModel: ErrorModel(
            statusCode: error.errorModel.statusCode,
            statusMessage: error.errorModel.statusMessage),
      );
    }
  }

  Future<List<PostModel>> searchPost(String query) async {
    List<PostModel>? response;
    if (query.isNotEmpty) {
      try {
        response = await Post().searchPostFormApi(query);
      } on ServerException catch (error) {
        throw ErrorModel(
            statusCode: error.errorModel.statusCode,
            statusMessage: error.errorModel.statusMessage);
      }
    }
    return response ?? [];
  }
}
