import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:template/features/post/data/logic/post.dart';
import 'package:template/features/post/data/model/error_model.dart';
import 'package:template/features/post/data/model/pagination.dart';
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

      final List<PostModel> response =
          await Post.getPosts(page: _pagePagination);

      final List<PostModel> updatedPosts = List<PostModel>.from(state.posts)
        ..addAll(response);

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

  void onRefresh(RefreshController refreshController) async {
    state = state
        .copyWith(isLoading: false, isError: false, hasMore: true, posts: []);
    _pagePagination = 1;
    await fetchPosts();
    refreshController.refreshCompleted();
  }
}
