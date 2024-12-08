import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/post/data/logic/post.dart';
import 'package:template/features/post/data/model/error_model.dart';
import 'package:template/features/post/data/model/pafination.dart';
import 'package:template/features/post/data/model/post_model.dart';

// StateNotifierProvider for managing Pagination state
final paginationPostsController =
    StateNotifierProvider<PaginationPostsProvider, Pagination>(
        (ref) => PaginationPostsProvider());

class PaginationPostsProvider extends StateNotifier<Pagination> {
  int _pagePagination = 1;

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

      _pagePagination++;

      final response = await Post.getPosts(page: _pagePagination);

      final updatedPosts = List<PostModel>.from(state.posts)..addAll(response);

      state = state.copyWith(
        isLoading: false,
        hasMore: response.isNotEmpty,
        posts: updatedPosts,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorModel: ErrorModel(message: e.toString()),
      );
    }
  }
}
